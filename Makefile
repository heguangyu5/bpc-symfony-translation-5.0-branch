libsymfony-component-translation.so:
	./bpc-prepare.sh src.list
	$(MAKE) -C ./Symfony libsymfony-component-translation

libsymfony-component-translation:
	bpc -v \
		-c bpc.conf  \
		-l symfony-component-translation \
		--pseudo-class-list Symfony\\Component\\Translation\\Exception\\InvalidArgumentException \
		-u symfony-contracts-translation \
		--input-file src.list

install-libsymfony-component-translation:
	cd Symfony && bpc -l symfony-component-translation --install
