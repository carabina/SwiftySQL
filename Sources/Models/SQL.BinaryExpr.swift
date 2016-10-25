//
//  SQL.OpExpr.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct BinaryExpr: SQLOperaorExprType, SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {

        let lhs: SQLExprType
        let op: String
        let rhs: SQLExprType
        
        public init(_ lhs: SQLExprType, _ op: String, _ rhs: SQLExprType) {
            self.lhs = lhs
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
            self.rhs = rhs
        }

        public init(_ lhs: SQLExprType, _ op: String, _ rhs: Keyword) {
            self.lhs = lhs
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
            self.rhs = rhs
        }

    }
    
}

extension SQLValueType {
    
    public func eq(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "=", expr)
    }
    
    public func gt(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, ">", expr)
    }
    
    public func ge(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, ">=", expr)
    }
    
    public func lt(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<", expr)
    }
    
    public func le(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<=", expr)
    }
    
    public func ne(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<>", expr)
    }
    
}

extension SQLConditionType {
    
    public func and(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "AND", expr)
    }
    
    public func andNot(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "AND", SQL.not(expr))
    }
    
    public func andExists(_ select: SQL.Select) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "AND", SQL.exists(select))
    }
    
    public func andNotExists(_ select: SQL.Select) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "AND", SQL.notExists(select))
    }
    
    public func or(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "OR", expr)
    }

    public func orNot(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "OR", SQL.not(expr))
    }
    
    public func orExists(_ select: SQL.Select) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "OR", SQL.exists(select))
    }
    
    public func orNotExists(_ select: SQL.Select) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "OR", SQL.notExists(select))
    }
    
}

extension SQLValueType {

    public func plus(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "+", expr)
    }
    
    public func minus(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "-", expr)
    }
    
    public func multiply(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "*", expr)
    }

    public func divide(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "/", expr)
    }

    public func mod(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "%", expr)
    }

    public func `is`(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS", expr)
    }

    public func isNot(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS NOT", expr)
    }

    public func concat(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "||", expr)
    }

    public func bitwiseAnd(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "|", expr)
    }
    
    public func bitwiseOr(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "&", expr)
    }

}

extension SQLValueType {

    public func like(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", pattern)
    }
    
    public func notLike(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "NOT LIKE", pattern)
    }
 
    public func likeIgnoreCase(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "LIKE", SQL.upper(pattern))
    }
    
    public func notLikeIgnoreCase(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "NOT LIKE", SQL.upper(pattern))
    }
    
    public func contains(_ substring: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", "%\(substring)%")
    }
    
    public func hasPrefix(_ prefix: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", "\(prefix)%")
    }
    
    public func hasSuffix(_ suffix: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", "%\(suffix)")
    }
    
}

extension SQLValueType {
    
    public func eq(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "=", prepared)
    }
    
    public func gt(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, ">", prepared)
    }
    
    public func ge(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, ">=", prepared)
    }
    
    public func lt(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<", prepared)
    }
    
    public func le(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<=", prepared)
    }
    
    public func ne(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<>", prepared)
    }
}

extension SQLConditionType {
    
    public func plus(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "+", prepared)
    }
    
    public func minus(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "-", prepared)
    }
    
    public func multiply(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "*", prepared)
    }

    public func divide(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "/", prepared)
    }
    
    public func mod(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "%", prepared)
    }
    
    public func `is`(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS", prepared)
    }
    
    public func isNot(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS NOT", prepared)
    }
    
    public func concat(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "||", prepared)
    }
    
    public func bitwiseAnd(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "|", prepared)
    }
    
    public func bitwiseOr(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "&", prepared)
    }
    
}

extension SQLValueType {
    
    public func like(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", prepared)
    }
    
    public func notLike(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "NOT LIKE", prepared)
    }
    
    public func likeIgnoreCase(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "LIKE", SQL.upper(prepared))
    }
    
    public func notLikeIgnoreCase(_ prepared: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "NOT LIKE", SQL.upper(prepared))
    }
    
}


