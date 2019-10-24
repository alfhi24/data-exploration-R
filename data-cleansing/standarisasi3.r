# Standarisasi kode pos

library(RMySQL)
#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")

#Konstruksi SQL
sql <- "SELECT pola_kode_pos, length(pola_kode_pos) as panjang_text, count(*) as jumlah_data
FROM dqlab_messy_data group by pola_kode_pos"

#Mengirimkan query
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data
profil_kode_pos <- fetch(rs, n=-1)
print(profil_kode_pos)

dbClearResult(rs)

#Menutup Koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons) dbDisconnect(con)



#Konstruksi SQL
sql <- "SELECT kode_pelanggan, kode_pos, pola_kode_pos FROM dqlab_messy_data WHERE pola_kode_pos IN ('99999A','9999A9')"

#Mengirimkan query
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data
data_kode_pos <- fetch(rs, n=-1)
print(data_kode_pos)


#Merubah nilai O dan I
data_kode_pos$kode_pos <- gsub("O", "0", data_kode_pos$kode_pos)
data_kode_pos$kode_pos <- gsub("I", "1", data_kode_pos$kode_pos)
print(data_kode_pos)

#Menulis data ke file
write.xlsx(file="staging.kode_pos.xlsx", x=data_kode_pos)

#Clear resultset
dbClearResult(rs)

#Menutup Koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons) dbDisconnect(con)
