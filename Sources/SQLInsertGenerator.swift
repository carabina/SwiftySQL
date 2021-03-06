//
//  SQLInsertGenerator.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLInsertGenerator: SQLQueryGenerator<SQLInsert> {
    
    func actionString(_ action: SQLInsert.Action) -> String {
        switch action {
        case .insert: return "INSERT"
        case .replace: return "REPLACE"
        case .insertOrReplace: return "INSERT OR REPLACE"
        case .insertOrRollback: return "INSERT OR ROLLBACK"
        case .insertOrAbort: return "INSERT OR ABORT"
        case .insertOrFail: return "INSERT OR FAIL"
        case .insertOrIgnore: return "INSERT OR IGNORE"
        }
    }
    
    override func generate(_ element: SQLInsert, forRead: Bool) -> String {
        return generateQuery(element, forRead: forRead)
    }
    
    override func generateFormatted(_ element: SQLInsert,
                                    forRead: Bool,
                                    withIndent indent: Int) -> String {
        return generateFormattedQuery(element, forRead: forRead, withIndent: indent)
    }
    
    override func generateQuery(_ element: SQLInsert, forRead: Bool) -> String {
        var query = actionString(element.action) + " INTO "
        query += element.table.sqlString(forRead: false, by: generator) + " "
        
        if element.columns.count > 0 {
            query += sqlJoin(element.columns, forRead: false, by: generator).boxed
            query += " "
        }
        
        if element.values.count > 0 {
            query += "VALUES "
            query += element.values
                .map { sqlJoin($0, forRead: false, by: generator).boxed }
                .joined(separator: ", ")
        } else if let select = element.select {
            query += select.query(by: generator)
        } else if element.columns.count == 0 {
            query += "DEFAULT VALUES"
        }
        
        return query
    }
    
    override func generateFormattedQuery(_ element: SQLInsert,
                                         forRead: Bool,
                                         withIndent indent: Int) -> String {
        var query = actionString(element.action) + " INTO "
        
        let paramIndent = indent + query.characters.count
        
        query += element.table.formattedSQLString(forRead: false,
                                                  withIndent: paramIndent,
                                                  by: generator)
        query += "\n"
        if element.columns.count > 0 {
            query += space(paramIndent)
            query += element.columns.map { $0.columnName }.joined(separator: ", ").boxedWithSpace
            query += "\n"
        }
        
        if element.values.count > 0 {
            query += space(indent) + "VALUES" + space(paramIndent - indent - 6)
            query += element.values
                .map { formattedSQLJoinBoxed($0,
                                             forRead: false,
                                             withIndent: paramIndent,
                                             by: generator) }
                .joined(separator: ",\n" + space(paramIndent))
        } else if let select = element.select {
            query += space(indent) + select.formattedQuery(withIndent: indent,
                                                           by: generator)
        } else if element.columns.count == 0 {
            query += space(indent) + "DEFAULT VALUES"
        }
        
        return query
    }
    
}
