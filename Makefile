
start-alice:
	docker run --rm --name alice -p 127.0.0.1:19442:19001 -p 19000:19000 custombtc
start-bob:
	docker run --rm --name bob  custombtc

connect:
	docker exec -ti alice bitcoin-cli -regtest addnode 172.17.0.1:19000 onetry
	docker exec -ti alice bitcoin-cli -regtest addnode 172.17.0.2:19000 onetry
	docker exec -ti alice bitcoin-cli -regtest addnode 172.17.0.3:19000 onetry
getPeer:
	docker exec -ti alice bitcoin-cli -regtest getpeerinfo

bash:
	docker exec -ti alice bash

generate:
	docker exec -ti alice bitcoin-cli -regtest generate 1
generate2016:
	docker exec -ti alice bitcoin-cli -regtest generate 2016

get:
	docker exec -ti alice bitcoin-cli -regtest getblocktemplate
getinfo:
	docker exec -ti alice bitcoin-cli -regtest getblockchaininfo

sendfrom1:
	$(BITCOINCLI) $(B1) sendtoaddress $(ADDRESS) $(AMOUNT)

sendfrom2:
	$(BITCOINCLI) $(B2) sendtoaddress $(ADDRESS) $(AMOUNT)

address1:
	$(BITCOINCLI) $(B1) getnewaddress $(ACCOUNT)

address2:
	$(BITCOINCLI) $(B2) getnewaddress $(ACCOUNT)

stop:
	$(BITCOINCLI) $(B1) stop
	$(BITCOINCLI) $(B2) stop

clean:
	find 1/regtest/* -not -name 'server.*' -delete
	find 2/regtest/* -not -name 'server.*' -delete
