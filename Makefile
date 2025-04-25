# Makefile for building protobufs and committing changes to GitHub

PROTO_SRC_DIR=proto
PROTO_OUT_DIR=go
PROTO_FILES=$(wildcard $(PROTO_SRC_DIR)/*.proto)
COMMIT_MSG="Update generated protobufs"

all: proto commit

proto:
	@echo "Generating Go code from .proto files..."
	protoc \
		-I=$(PROTO_SRC_DIR) \
		--go_out=. \
		--go-grpc_out=. \
		$(PROTO_FILES)

commit:
	@echo "Adding and committing generated files..."
	git add $(PROTO_OUT_DIR)
	git commit -m $(COMMIT_MSG) || echo "No changes to commit"
	git push origin main

clean:
	rm -rf $(PROTO_OUT_DIR)/*

.PHONY: all proto commit clean