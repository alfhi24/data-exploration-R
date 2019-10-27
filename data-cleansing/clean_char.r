library(RMySQL)
con <- dbConnect(MySQL(), user="demo", password="demo", host="mysqlhost",
                 dbname="dqlabdatawrangling")
sql <- "SELECT kode_pelanggan, nama from dqlab_messy_data where nama REGEXP '[^A-Za-z .,]'"

rs <- tryCatch(dbSendQuery(con, sql), finally = print("query ok"))

data.pelanggan <- fetch(rs, n=-1)
data.pelanggan
data.pelanggan$nama <- gsub("[^A-Za-z .,]", "", data.pelanggan$nama)
data.pelanggan$nama <- trimws(data.pelanggan$nama, which="both")
data.pelanggan

all_cons <- dbListConnections(MySQL())
for(con in all_cons) dbDisconnect(con)
