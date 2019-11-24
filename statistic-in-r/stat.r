library(pracma)
data_intro <- read.csv("data_intro.csv", sep=";")
# data_intro
str(data_intro)

#MENYESUAIKAN TIPE DATA UNTUK DIANALISIS
## mengubah data menjadi karakter karena tidak dilakukan analisis statistik pada variabel ID Pelanggan dan nama
data_intro$ID.Pelanggan <- as.character(data_intro$ID.Pelanggan)
data_intro$Nama <- as.character(data_intro$Nama)

## melihat apakah sudah berhasil dalam mengubah variabel tersebut

## Mengubah data menjadi factor untuk membedakan data kualitatif dengan menggunakan functon as.factor
data_intro$Jenis.Kelamin <- as.factor(data_intro$Jenis.Kelamin)
data_intro$Produk <- as.factor(data_intro$Produk)
data_intro$Tingkat.Kepuasan <- as.factor(data_intro$Tingkat.Kepuasan)

## Melihat apakah sudah berhasil dalam mengubah variabel tersebut dengan menggunakan function str
str(data_intro)

# #Nilai modus
Mode(data_intro$Produk)
median(data_intro$Total)
mean(data_intro$Total)
summary(data_intro)
# ## carilah range untuk kolom Pendapatan pada variable data_intro
max(data_intro$Pendapatan)-min(data_intro$Pendapatan)
# ## Carilah varians untuk kolom Pendapatan dari variable data_intro
var(data_intro$Pendapatan)
sd(data_intro$Jumlah)
# ## Carilah sebaran data kolom Jenis.Kelamin dari variable data_intro
plot(data_intro$Jenis.Kelamin)

# ## Carilah sebaran data dari Pendapatan dari variable data_intro
#hist(data_intro$Pendapatan)

#plot(data_intro$Pendapatan,data_intro$Total)
