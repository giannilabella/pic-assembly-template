PROJECT_NAME = template
PROCESSOR    = p16f877a # Required by disassembler

SOURCE_FILE = template-p16f877a.asm
SOURCE_DIR = src/
OUTPUT_DIR = out/

SOURCE_PATH = $(SOURCE_DIR:%/=%/$(SOURCE_FILE))
HEX_FILE_PATH = $(OUTPUT_DIR:%/=%/$(PROJECT_NAME).hex)
COD_FILE_PATH = $(OUTPUT_DIR:%/=%/$(PROJECT_NAME).cod)

ASM = gpasm --mpasm-compatible
DASM = gpdasm -p $(PROCESSOR)
COD = gpvc -d

all: $(HEX_FILE_PATH)

$(COD_FILE_PATH): $(HEX_FILE_PATH)

$(HEX_FILE_PATH): $(SOURCE_PATH)
	@echo "Assembling..."
	@$(ASM) -o $(HEX_FILE_PATH) $(SOURCE_PATH)
	@echo "Done ✓"

dasm: $(HEX_FILE_PATH)
	@echo "Disassembling..."
	@$(DASM) $(HEX_FILE_PATH)
	@echo "Done ✓"

viewcod: $(COD_FILE_PATH)
	@$(COD) $(COD_FILE_PATH)

.PHONY: clean
clean:
	@echo "Cleaning..."
	@rm $(OUTPUT_DIR:%/=%/*.hex) $(OUTPUT_DIR:%/=%/*.cod) $(OUTPUT_DIR:%/=%/*.lst)
	@echo "Done ✓"