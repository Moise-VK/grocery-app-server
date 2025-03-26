import Vapor
import Fluent
import FluentPostgresDriver

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
    
    // register routes
    try routes(app)
}
