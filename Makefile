PROTO_SRC_DIR=proto
PROTO_OUT_DIR=go
PROTO_FILES=$(shell find $(PROTO_SRC_DIR) -name "*.proto")
COMMIT_MSG="Update generated protobufs"

all: proto commit

proto:
	@echo "Generating Go code from .proto files..."
	@mkdir -p $(PROTO_OUT_DIR)
	@for file in $(PROTO_FILES); do \
		protoc \
			-I=$(PROTO_SRC_DIR) \
			--go_out=paths=source_relative:$(PROTO_OUT_DIR) \
			--go-grpc_out=paths=source_relative:$(PROTO_OUT_DIR) \
			$$file; \
	done

commit:
	@echo "Adding and committing generated files..."
	git add $(PROTO_OUT_DIR)
	git commit -m $(COMMIT_MSG) || echo "No changes to commit"
	git push origin main

clean:
	rm -rf $(PROTO_OUT_DIR)/*

.PHONY: all proto commit clean
