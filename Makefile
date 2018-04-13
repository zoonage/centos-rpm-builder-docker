build_centos6:
	docker build --pull --force-rm \
		--tag zoonage/centos6-rpm-builder \
		--file Dockerfile.centos6 .
build_centos7:
	docker build --pull --force-rm \
		--tag zoonage/centos7-rpm-builder \
		--file Dockerfile.centos7 .

build: build_centos6 build_centos7

test: build	test_centos7 test_centos6 

test_centos6:
	docker run --rm \
		-v ${PWD}/tests/:/rpmbuild/SOURCES/ \
		-v ${PWD}/_dist:/rpmbuild/ \
		zoonage/centos6-rpm-builder \
build-spec SOURCES/test1.spec

test_centos7:
	docker run --rm \
		-v ${PWD}/tests/:/rpmbuild/SOURCES/ \
		-v ${PWD}/_dist:/rpmbuild/ \
		zoonage/centos7-rpm-builder build-spec /rpmbuild/SOURCES/test1.spec

clean:
	rm -rf _dist
	rm **/*.tar.gz
	rm **/*.jar
	
