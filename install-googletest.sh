DISTFILES_URL=http://nexus/repository/unsupported/distfiles
curl -sL $DISTFILES_URL/googletest/release-1.8.0.tar.gz \
| tar zxf - --strip-components 1 -C googletest
