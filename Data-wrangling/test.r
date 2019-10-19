library(openxlsx)
library(reshape2)
data_penduduk <- read.xlsx(xlsxFile="dkikepadatankelurahan2013.xlsx")
data_penduduk$NAMA.PROVINSI <- as.factor(data_penduduk$NAMA.PROVINSI)
data_penduduk$NAMA.KABUPATEN/KOTA <- as.factor(data_penduduk$NAMA.KABUPATEN/KOTA)
data_penduduk$NAMA.KECAMATAN <- as.factor(data_penduduk$NAMA.KECAMATAN)
data_penduduk$NAMA.KELURAHAN <- as.factor(data_penduduk$NAMA.KELURAHAN)
str(data_penduduk)
#Tampilkan seluruh data penduduk
data_penduduk

#Tampilkan kolom yang mengandung kata "perempuan".
perempuan <- grep(pattern="perempuan", x = names(data_penduduk), ignore.case=TRUE)
names(data_penduduk[perempuan])

#Tampilkan nama-nama kolom yang mengandung kata "laki-laki"
laki_laki <- grep(pattern="laki-laki", x = names(data_penduduk), ignore.case=TRUE)
names(data_penduduk[laki_laki])

#Transformasi kolom dataset, disimpan ke variable data_penduduk_transform
data_penduduk_transform <- melt(data=data_penduduk, id.vars=c( "NAMA.KECAMATAN", "NAMA.KELURAHAN"), measure.vars = c("35-39.Laki-Laki", "35-39.Perempuan"), variable.name = "DEMOGRAFIK", value.name="JUMLAH")
data_penduduk_transform

#Split isi kolom DEMOGRAFIK menjadi "RENTANG.UMUR" dan "JENIS.KELAMIN"
data_penduduk_transform[c("RENTANG.UMUR", "JENIS.KELAMIN")] <- colsplit(data_penduduk_transform$DEMOGRAFIK,"\\.",c("RENTANG.UMUR","JENIS.KELAMIN"))
data_penduduk_transform$DEMOGRAFIK <- NULL
data_penduduk_transform