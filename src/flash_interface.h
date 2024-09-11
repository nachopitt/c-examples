int flash_interface_init(char *sound_file_name);
int flash_interface_close();

typedef struct flash_interface {
    int (*init)(char*);
	int (*close)();
} flash_interface;

flash_interface* get_flash_interface();
