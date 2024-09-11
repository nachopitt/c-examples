#include <stdio.h>

#include "flash_interface.h"

int main(int argc, char* argv[]) {
    flash_interface* flash_if;
    flash_if = get_flash_interface();

    flash_if->init("File_General");
    flash_if->close();

    return 0;
}

