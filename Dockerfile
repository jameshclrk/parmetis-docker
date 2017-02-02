FROM jameshclrk/mpich

MAINTAINER James Clark <james.clark@stfc.ac.uk>

ENV METIS_VERSION 5.1.0
ENV PARMETIS_VERSION 4.0.3

RUN set -x \
	&& curl -fSL "http://glaros.dtc.umn.edu/gkhome/fetch/sw/metis/metis-$METIS_VERSION.tar.gz" -o metis.tar.gz \
	&& mkdir -p /usr/src/metis \
	&& tar -xf metis.tar.gz -C /usr/src/metis --strip-components=1 \
	&& rm metis.tar.gz* \
	&& cd /usr/src/metis \
	&& make config \
	&& make -j"$(nproc)" \
	&& make install
RUN set -x \
	&& curl -fSL "http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-$PARMETIS_VERSION.tar.gz" -o parmetis.tar.gz \
	&& mkdir -p /usr/src/parmetis \
	&& tar -xf parmetis.tar.gz -C /usr/src/parmetis --strip-components=1 \
	&& rm parmetis.tar.gz* \
	&& cd /usr/src/parmetis \
	&& dir="$(mktemp -d)" \
	&& make config \
	&& make -j"$(nproc)" \
	&& make install
