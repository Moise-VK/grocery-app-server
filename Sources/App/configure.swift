import Vapor
import Fluent
import FluentPostgresDriver
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    let connectionString = Environment.get("CONNECTION_STRING") ?? ""
    
    try app.databases.use(.postgres(url: connectionString), as: .psql)
    
    //register migrations
    app.migrations.add(CreateUsersTableMigration())
  
  //register the controllers
  try app.register(collection: UserController())
  
  let jwtSalt = Environment.get("JWT_SALT")
  
  if (jwtSalt == nil) {
    fatalError("JWT_SALT environment variable must be set.")
  }
  
  app.jwt.signers.use(.hs256(key: jwtSalt!))
    
    // register routes
    try routes(app)
}
