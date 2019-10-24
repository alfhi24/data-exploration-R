# Standarisasi alamat

library(RMySQL)
#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")
#Konstruksi SQL
sql <- "SELECT kode_pelanggan, alamat, pola_alamat from dqlab_messy_data where pola_alamat REGEXP '^[aAw]+$' or pola_alamat REGEXP '^[9w]+$'"

#Mengirimkan query
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data
data_alamat <- fetch(rs, n=-1)
print(data_alamat)

#Clear resultset
dbClearResult(rs)

#Menutup Koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons) dbDisconnect(con)


                 dbname="dqlabdatawrangling")
#Konstruksi SQL
sql <- "SELECT kode_pelanggan, alamat from dqlab_messy_data"

#Mengirimkan query
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))
#Mengambil data
data_alamat <- fetch(rs, n=-1)

#Merubah singkatan jl, jln, jl. dan jln. menjadi Jalan
data_alamat$alamat <- gsub("jln[ ]*\\.", "", data_alamat$alamat, ignore.case = TRUE)
data_alamat$alamat <- gsub("\\bjln\\b", "", data_alamat$alamat, ignore.case = TRUE)
data_alamat$alamat <- gsub("jl[ ]*\\.", "", data_alamat$alamat, ignore.case = TRUE)
data_alamat$alamat <- gsub("\\bjl\\b", "", data_alamat$alamat, ignore.case = TRUE)
data_alamat$alamat <- gsub("jalan\\.", "", data_alamat$alamat, ignore.case = TRUE)
print(data_alamat)
#Menulis data ke file
write.xlsx(file="staging.alamat.xlsx", x= data_alamat)

#Clear resultset
dbClearResult(rs)

#Menutup Koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons) dbDisconnect(con)
