//
//  SQL.TernaryExpr+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.TernaryExpr {
    
    class Generator: SQLElementGenerator<SQL.TernaryExpr> {
        
        override func generate(_ element: SQL.TernaryExpr) -> String {
            var query = element.lhs.sqlStringBoxedIfNeeded(by: generator)
            query += " \(element.lop) "
            query += element.chs.sqlStringBoxedIfNeeded(by: generator)
            query += " \(element.rop) "
            query += element.rhs.sqlStringBoxedIfNeeded(by: generator)
            
            return query
        }
        
        override func generateFormatted(_ element: SQL.TernaryExpr,
                                        withIndent indent: Int) -> String {
            var query = element.lhs.formattedSQLStringBoxedIfNeeded(withIndent: indent, by: generator)
            query += " " + element.lop + " "

            let lind = indent + query.characters.count
            
            query += element.chs.formattedSQLStringBoxedIfNeeded(withIndent: lind, by: generator)
            query += " " + element.rop + " "

            let rind = indent + query.characters.count
            
            query += element.rhs.formattedSQLStringBoxedIfNeeded(withIndent: rind, by: generator)
            
            return query
        }
        
        
    }
    
}
