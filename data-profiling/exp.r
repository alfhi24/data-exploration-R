library(openxlsx)
library(bpa)
data.pelanggan <- read.xlsx("dqlab_messy_data_pelanggan.xlsx",sheet="Pelanggan")
data.pelanggan
str(data.pelanggan)
#Merubah kolom data selain Nilai.Belanja.Setahun menjadi factor
data.pelanggan$Kode.Pelanggan <- as.factor(data.pelanggan$Kode.Pelanggan)
data.pelanggan$Nama.Lengkap <- as.factor(data.pelanggan$Nama.Lengkap)
data.pelanggan$Alamat <- as.factor(data.pelanggan$Alamat)
data.pelanggan$Tanggal.Lahir <- as.factor(data.pelanggan$Tanggal.Lahir)
data.pelanggan$Aktif <- as.factor(data.pelanggan$Aktif)
data.pelanggan$Kode.Pos <- as.factor(data.pelanggan$Kode.Pos)
data.pelanggan$No.Telepon <- as.factor(data.pelanggan$No.Telepon)

#Menggunakan function summary
summary(data.pelanggan) 
basic_pattern_analysis(data.pelanggan$Kode.Pelanggan, unique_only = TRUE)
basic_pattern_analysis(data.pelanggan$Kode.Pelanggan)=="AA-99999"
data.pelanggan[ basic_pattern_analysis(data.pelanggan$Kode.Pelanggan)=="AA-9999" , ]
basic_pattern_analysis(data.pelanggan$Nama, unique_only = TRUE)

#Menggunakan function grepl untuk mengambil pola nama tidak lazim
data.pelanggan[grepl(pattern="[^Aaw.,]", x=basic_pattern_analysis(data.pelanggan$Nama)),]
data.pelanggan[grepl(pattern="ww", x=basic_pattern_analysis(data.pelanggan$Nama)),]

#Profiling pola seluruh kolom
basic_pattern_analysis(data.pelanggan)

#Melakukan profiling terhadap seluruh kolom data.pelanggan 
pola.data.pelanggan <- basic_pattern_analysis(data.pelanggan)

#Merubah nama kolom
names(pola.data.pelanggan)<-paste("Pola",names(pola.data.pelanggan),sep=".")

#Menggabungkan dua data.frame
data.pelanggan <- cbind(data.pelanggan, pola.data.pelanggan)
#Menampilkan struktur
str(data.pelanggan)
#Menulis File Excel
write.xlsx(data.pelanggan, file="data.pelanggan.xlsx")