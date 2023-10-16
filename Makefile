all: eval make-noopt make-opt

eval:
	@echo "## Using malfunction eval to compute expected value:"
	sed -e 's/module/let/g' -e 's/(export \$$test_bytestring)/(apply \$$test_bytestring 0)/g' test_bytestring.mlf | malfunction eval
	@echo ""

make-noopt:
	@echo "## Using malfunction cmx to compile and print value:"
	ocamlopt -c test_bytestring.mli
	malfunction cmx test_bytestring.mlf 
	ocamlopt -c main.ml
	ocamlopt -o main test_bytestring.cmx main.cmx
	./main

make-opt:
	@echo "## Using malfunction cmx -O2 to compile and print value:"
	ocamlopt -c test_bytestring.mli
	malfunction cmx -O2 test_bytestring.mlf
	ocamlopt -c main.ml
	ocamlopt -o main-opt test_bytestring.cmx main.cmx
	./main-opt
