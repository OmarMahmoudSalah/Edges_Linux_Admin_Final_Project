# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application/build

# Utility rule file for clean_all_edges.

# Include any custom commands dependencies for this target.
include CMakeFiles/clean_all_edges.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/clean_all_edges.dir/progress.make

CMakeFiles/clean_all_edges:
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Cleaning all files"
	/usr/bin/cmake -E remove_directory /home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application/../Application/out/gen
	/usr/bin/cmake -E remove_directory /home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application/../Application/out/libs
	/usr/bin/cmake -E remove /home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application/../Application/out/output

clean_all_edges: CMakeFiles/clean_all_edges
clean_all_edges: CMakeFiles/clean_all_edges.dir/build.make
.PHONY : clean_all_edges

# Rule to build all files generated by this target.
CMakeFiles/clean_all_edges.dir/build: clean_all_edges
.PHONY : CMakeFiles/clean_all_edges.dir/build

CMakeFiles/clean_all_edges.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/clean_all_edges.dir/cmake_clean.cmake
.PHONY : CMakeFiles/clean_all_edges.dir/clean

CMakeFiles/clean_all_edges.dir/depend:
	cd /home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application /home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application /home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application/build /home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application/build /home/omar/Final_Project/Part2_MakeFiles_Cmake/01_Cmake/Application/build/CMakeFiles/clean_all_edges.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/clean_all_edges.dir/depend

