FROM centos:7


LABEL     mantainer="Lucas Nunes da Silva"

RUN  yum install -y epel-release httpd

RUN     yum install -y perl-App-cpanminus \
        perl-Dist-CheckConflicts \
        perl-HTML-Parser \
        perl-libwww-perl \
        perl-Module-Implementation \
        perl-Module-ScanDeps \
        perl-Package-Stash \
        perl-Package-Stash-XS \
        perl-PAR-Packer \
        perl-Regexp-Common \
        perl-Sys-MemInfo \
        perl-Test-Fatal \
        perl-Test-Mock-Guard \
        perl-Test-Requires \
        perl-Test-Deep \
        perl-File-Tail \
        perl-Unicode-String \
        perl-Test-NoWarnings \
        perl-Test-Simple \
        perl-Test-Warn \
        perl-Sub-Uplevel \
        cpanminus

RUN     yum install -y imapsync

RUN     cpanm Encode::IMAPUTF7

RUN     cpanm CGI

WORKDIR /var/www/html/X/

RUN     mkdir -p /var/www/html/X 

COPY    /web/.  /var/www/html/X/

RUN     ln -s /var/www/html/X/imapsync_form_extra.html /var/www/html/X/index.html

COPY /conf/httpd.conf /etc/httpd/conf/httpd.conf

COPY /conf/imapsync /var/www/cgi-bin/imapsync

RUN chmod +x /var/www/cgi-bin/imapsync

RUN httpd -k restart

ENV PORT=80

EXPOSE $PORT 

CMD [ "-D", "FOREGROUND" ]

ENTRYPOINT [ "httpd" ]





