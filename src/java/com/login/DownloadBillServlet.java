/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.login;



import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.example.util.DatabaseUtility;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;

@WebServlet("/DownloadBillServlet")
public class DownloadBillServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        try (Connection conn = DatabaseUtility.getConnection();
             PreparedStatement stmt = conn.prepareStatement("SELECT * FROM bookings WHERE booking_id=?")) {
            
            stmt.setInt(1, bookingId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                response.setContentType("application/pdf");
                response.setHeader("Content-Disposition", "attachment; filename=RideBill_" + bookingId + ".pdf");

                OutputStream out = response.getOutputStream();
                Document document = new Document();
                PdfWriter.getInstance(document, out);
                document.open();

                // Add Content
                document.add(new Paragraph("MegaCityCab - Ride Invoice", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.BLUE)));
                document.add(new Paragraph("------------------------------------------------------"));
                document.add(new Paragraph("Booking ID: " + rs.getInt("booking_id")));
                document.add(new Paragraph("Vehicle: " + rs.getString("vehicle_type")));
                document.add(new Paragraph("Pickup: " + rs.getString("pickup_location")));
                document.add(new Paragraph("Drop: " + rs.getString("drop_location")));
                document.add(new Paragraph("Date/Time: " + rs.getString("ride_datetime")));
                document.add(new Paragraph("Driver: " + rs.getString("driver_name")));
                document.add(new Paragraph("Fare: LKR " + rs.getString("fare")));
                document.add(new Paragraph("Status: " + rs.getString("status")));
                document.add(new Paragraph("------------------------------------------------------"));
                document.add(new Paragraph("Thank you for choosing MegaCityCab!", FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.GREEN)));

                document.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
