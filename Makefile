GO_SERVICE_NAME:=isu-go.service

.PHONY: deploy
deploy:
	bash ./deploy.sh

.PHONY: log
log:
	sudo journalctl -u ${GO_SERVICE_NAME} -n10 -f

.PHONY: analyze
analyze:
	bash ./analyze.sh > analyze_result

.PHONY: pprof
pprof:
	go tool pprof -http=0.0.0.0:1080 ./go http://localhost:6060/debug/pprof/profile

.PHONY: setup
setup:
    sudo apt install -y graphviz gv
    wget https://github.com/tkuchiki/slp/releases/download/v0.2.0/slp_linux_amd64.tar.gz
    tar -xvf slp_linux_amd64.tar.gz
    sudo mv slp /usr/local/bin/slp
    wget https://github.com/tkuchiki/alp/releases/download/v1.0.21/alp_linux_amd64.tar.gz
    tar -xvf alp_linux_amd64.tar.gz
    sudo mv alp /usr/local/bin/alp
    wget https://github.com/kaz/pprotein/releases/download/v1.2.3/pprotein_1.2.3_linux_amd64.tar.gz
    tar -xvf pprotein_1.2.3_linux_amd64.tar.gz

.PHONY: conf
conf:
	cp /etc/nginx/nginx.conf ./nginx1.conf
	cp /etc/nginx/nginx.conf ./nginx2.conf
	cp /etc/nginx/nginx.conf ./nginx3.conf
	cp /etc/mysql/mysql.conf.d/mysqld.cnf ./mysqld.cnf