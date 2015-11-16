FD_VER=3.01b

FD_SRC=FD-$(FD_VER).tar.gz
FD_URL=http://hp.vector.co.jp/authors/VA012337/soft/fd/$(FD_SRC)

TOOLS=/usr/bin/wget /usr/bin/rpmbuild /usr/bin/gcc /usr/include/curses.h
BIN=~/rpmbuild/RPMS/x86_64/FDclone-$(FD_VER)-1.x86_64.rpm

.PHONY: clean all install patch

$(BIN): $(FD_SRC) $(TOOLS)
	rpmbuild -tb --clean $(FD_SRC)

$(FD_SRC):
	wget $(FD_URL) -O $(FD_SRC)

/usr/bin/wget:
	sudo yum install -y wget

/usr/bin/rpmbuild:
	sudo yum install -y rpm-build

/usr/bin/gcc:
	sudo yum install -y gcc

/usr/include/curses.h:
	sudo yum install -y ncurses-devel

clean:
	rm -f *.tar.gz
	rm -f $(BIN)

all: clean $(BIN)

install: $(BIN)
	sudo rpm -i $(BIN)

patch:
	sudo patch /etc/fd2rc <fd2rc.patch
