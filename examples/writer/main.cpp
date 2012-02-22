#include "Writer.h"

#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <string>

// Writer which writes to a file
struct FileWriter {
	FileWriter(const char* path) {
		fd = open(path,O_CREAT | O_WRONLY,S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH);
	};

	~FileWriter() {
		close(fd);
	}

	int write(const char* data, int len) {
		return ::write(fd,data,len);
	}

	int fd;
};

// Writer which does nothing
struct NoOpWriter {
	int write(const char*, int len) {
		return len;
	}
};

// Writer which outputs to the console
struct ConsoleWriter {
	int write(const char* data, int len) {
		printf("%s\n",data);
	}
};

int main(int argc, char** argv)
{
	if (argc < 2) {
		if (argc < 1) {
			return 1;
		}
		printf("Usage: %s (<filename>|\"console\"|\"null\") <text>\n",argv[0]);
		return 0;
	}

	std::string path(argv[1]);

	Writer writer;
	if (path == "console") {
		writer = new ConsoleWriter;
	} else if (path == "null") {
		writer = new NoOpWriter;
	} else {
		writer = new FileWriter(path.c_str());
	}

	std::string text;
	for (int i=2; i < argc; i++) {
		if (!text.empty()) {
			text += ' ';
		}
		text += argv[i];
	}
	
	writer.write(text.c_str(),text.size());
	writer.destroy();

	return 0;
}
