package com.learning.db.mybatis.core;

import java.sql.*;

/**
 * Created by IntelliJ IDEA.
 * User: asmudun
 * Date: Jul 4, 2013
 * Time: 1:45:51 PM
 */
public class CoreJDBC {

    public static void main(String[] args) {
        try {
            getConnection();
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    private static Statement getConnection() throws Exception {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/test1", "test1", "test1");
        Statement stmt = con.createStatement();
        System.out.println("---- stmt ----" + stmt);
        return stmt;
    }

}
