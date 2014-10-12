
# This programs demonstrates how Ruby may be used to parse JSON strings.
# Ruby represents the JSON object as a hash.
# Author: Jian Yang
# Laste updated: 10/05/13
# Email: jiany1@andrew.cmu.edu

require 'net/http'
require 'json'


# Go out to the internet and collect some JSON
# Prompter for user to enter an ID
print "Please enter the product id: "
product_id = gets.chomp
# Set up the URL
url = "http://services.odata.org/Northwind/Northwind.svc/Products(#{product_id})?$format=json"
# Make an HTTP request and place the result in jsonStr
jsonStr = Net::HTTP.get_response(URI.parse(url))
data = jsonStr.body
jsonHash = JSON.parse(data)
if (jsonHash["Discontinued"]) #if a product is a discontinued product
      puts jsonHash["ProductName"].to_s + " is a discontinued product"
   else         
            supplier_id = jsonHash["SupplierID"].to_s#get the SupplierID from Products url
            #construct a url for retrieving supplier
            urlSupplier = "http://services.odata.org/Northwind/Northwind.svc/Suppliers(#{supplier_id})?$format=json"
            # Make an HTTP request and place the result in jsonStrSupplier
            jsonStrSupplier = Net::HTTP.get_response(URI.parse(urlSupplier))
            dataSupplier = jsonStrSupplier.body
            jsonSupplierHash = JSON.parse(dataSupplier)#parse the json data from the text
            # print the SupplierName, note that the actual supplier name is labeled as "Company Name"
            if jsonHash["ProductName"]#if productName is not nil
                  puts "ProductName: " + jsonHash["ProductName"].to_s #prints the product name
            else
                  puts "ProductName: " + "n/a"#else print n/a
            end

            if jsonSupplierHash["CompanyName"]#if companyName is not nil
                  puts "SupplierName: " + jsonSupplierHash["CompanyName"].to_s #prints the Supplier name
            else
                  puts "SupplierName: " + "n/a" #else print n/a
            end  
      
end

puts ""
 

