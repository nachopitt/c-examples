#include <stdio.h>

#include "flash_interface.h"

static flash_interface flash_if_instance = {
    .init = flash_interface_init,
    .close = flash_interface_close,
};

flash_interface* get_flash_interface() {
    return &flash_if_instance;
}

int flash_interface_init(char *sound_file_name) {
    printf("init - sound_file_name: %s\n", sound_file_name);

    return 0;
}

int flash_interface_close() {
    printf("close\n");

    return 0;
}
