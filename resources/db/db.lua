
db = dbConnect(	"mysql",
				"host=HOST;dbname=DBNAME", --host and db name
				"", --username
				"", --password
				"autoreconnect=1"
			)

function getDB()
	return db
end
