# Standarisasi nomor hp

library(RMySQL)
library(ggplot2)

#Membuka koneksi
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")

#Konstruksi SQL
sql <- "SELECT pola_no_telepon, length(pola_no_telepon) as panjang_text, count(*) as jumlah_data from dqlab_messy_data group by pola_no_telepon"

#Mengirimkan query
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data
profil_no_telepon <- fetch(rs, n=-1)
print(profil_no_telepon)

#Plotting data
plot.profile <- ggplot(data=profil_no_telepon, aes(x = pola_no_telepon, y = jumlah_data, fill = pola_no_telepon))

plot.profile <- plot.profile + theme(axis.text.x = element_text(angle=45,vjust = 0.5))

plot.profile + geom_bar(stat="identity")

#Clear resultset
dbClearResult(rs)


#Konstruksi SQL untuk Profil 1
sql <- "SELECT left(no_telepon,1) as prefix_no_telepon, pola_no_telepon
from dqlab_messy_data where pola_no_telepon = '999999999999999'
group by left(no_telepon,1), pola_no_telepon"

#Mengirimkan query untuk Profil 1
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data untuk Profil 1
profil_no_telepon <- fetch(rs, n=-1)
print(profil_no_telepon)

#Clear resultset untuk Profil 1
dbClearResult(rs)

#Konstruksi SQL untuk Profil 2
sql <- "SELECT left(no_telepon,2) as prefix_no_telepon, pola_no_telepon
from dqlab_messy_data where pola_no_telepon = '9999999999999999'
group by left(no_telepon,2), pola_no_telepon"

#Mengirimkan query untuk Profil 2
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data untuk Profil 2
profil_no_telepon <- fetch(rs, n=-1)
print(profil_no_telepon)

#Clear resultset untuk Profil 2
dbClearResult(rs)

#Konstruksi SQL untuk Profil 3
sql <- "SELECT left(no_telepon,3) as prefix_no_telepon, pola_no_telepon
from dqlab_messy_data where pola_no_telepon = '+9999999999999999'
group by left(no_telepon,3), pola_no_telepon"

#Mengirimkan query untuk Profil 3
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data untuk Profil 3
profil_no_telepon <- fetch(rs, n=-1)
print(profil_no_telepon)

#Clear resultset untuk Profil 3
dbClearResult(rs)

#Menutup Koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons) dbDisconnect(con)


#Konstruksi SQL untuk Profil 1
sql <- "select kode_pelanggan, no_telepon, pola_no_telepon from dqlab_messy_data"

#Mengirimkan query untuk standarisasi no_telepon
rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

#Mengambil data untuk standarisasi no_telepon
data.telepon <- fetch(rs, n=-1)
data.telepon$anomali_no_telepon <- TRUE

data.telepon[data.telepon$pola_no_telepon=="9999999999999999",]$no_telepon <- paste("+", data.telepon[data.telepon$pola_no_telepon=="9999999999999999",]$no_telepon, sep="")
data.telepon[data.telepon$pola_no_telepon=="999999999999999",]$no_telepon <- gsub("^0","+62",  data.telepon[data.telepon$pola_no_telepon=="999999999999999",]$no_telepon)
data.telepon[data.telepon$pola_no_telepon=="+9999999999999999",]$anomali_no_telepon <- FALSE 
data.telepon[data.telepon$pola_no_telepon=="9999999999999999",]$anomali_no_telepon <- FALSE 
data.telepon[data.telepon$pola_no_telepon=="999999999999999",]$anomali_no_telepon <- FALSE
print(data.telepon)

write.xlsx(file="staging.no_telepon.xlsx", x=data.telepon)

#Clear resultset untuk standarisasi
dbClearResult(rs)

#Menutup Koneksi
all_cons <- dbListConnections(MySQL())
for(con in all_cons) dbDisconnect(con)
