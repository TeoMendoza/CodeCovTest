# Variables
SHELL = /bin/bash
CXX = g++
CXXFLAGS = -std=c++17 -I/opt/homebrew/Cellar/googletest/1.15.2/include -Wall -Wextra -fprofile-arcs -ftest-coverage
LDFLAGS = -L/opt/homebrew/Cellar/googletest/1.15.2/lib -lgtest -lgtest_main -pthread -fprofile-arcs -ftest-coverage
SRCS = dynamic_array_test.cpp
OBJS = $(SRCS:.cpp=.o)
EXEC = test_run
COV_DIR = coverage_report

# Target to build the executable
$(EXEC): $(OBJS) dynamic_array.h
	$(CXX) $(OBJS) -o $(EXEC) $(LDFLAGS)

# Rule to compile .cpp files into .o files
%.o: %.cpp dynamic_array.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Rule to run the tests and generate coverage data

test: $(EXEC)
	./$(EXEC)                            # Run the tests to generate coverage data
	bash <(curl -s https://codecov.io/bash) -t 5711eb10-0699-4268-89c9-3d132dbc5dfe

# Clean up build artifacts and coverage data
clean:
	rm -f $(OBJS) $(EXEC) *.gcno *.gcda *.gcov
	rm -rf $(COV_DIR)  # Optionally clean up coverage reports



# Variables
# CXX = g++
# CXXFLAGS = -std=c++17 -I/opt/homebrew/Cellar/googletest/1.15.2/include -Wall -Wextra -fprofile-arcs -ftest-coverage
# LDFLAGS = -L/opt/homebrew/Cellar/googletest/1.15.2/lib -lgtest -lgtest_main -pthread -fprofile-arcs -ftest-coverage
# SRCS = dynamic_array_test.cpp
# OBJS = $(SRCS:.cpp=.o)
# EXEC = test_run
# COV_DIR = coverage_report

# # Target to build the executable
# $(EXEC): $(OBJS)
# 	$(CXX) $(OBJS) -o $(EXEC) $(LDFLAGS)

# # Rule to compile .cpp files into .o files
# %.o: %.cpp dynamic_array.h
# 	$(CXX) $(CXXFLAGS) -c $< -o $@

# # Rule to run the tests and generate coverage data
# test: $(EXEC)
# 	./$(EXEC)                             # Run the tests to generate coverage data
# 	mkdir -p $(COV_DIR)                  # Create coverage directory if it doesn't exist

# 	gcov -o . dynamic_array_test.cpp           # Generate .gcov files for your specific source files
# 	cp *.gcov $(COV_DIR)                  # Copy the generated .gcov files to the coverage directory

# 	lcov --capture --directory . --output-file $(COV_DIR)/coverage.info --ignore-errors inconsistent
# 	lcov --remove $(COV_DIR)/coverage.info '/usr/*' --output-file $(COV_DIR)/coverage.info --ignore-errors inconsistent
# 	lcov --list $(COV_DIR)/coverage.info --ignore-errors inconsistent 
# 	genhtml $(COV_DIR)/coverage.info --output-directory $(COV_DIR) --ignore-errors inconsistent,corrupt,missing


# clean:
# 	rm -f $(OBJS) $(EXEC) *.gcno *.gcda *.gcov
# 	rm -rf $(COV_DIR)/*


# # Variables
# CXX = g++
# CXXFLAGS = -std=c++17 -I/opt/homebrew/Cellar/googletest/1.15.2/include -Wall -Wextra
# LDFLAGS = -L/opt/homebrew/Cellar/googletest/1.15.2/lib -lgtest -lgtest_main -pthread
# SRCS = dynamic_array_test.cpp
# OBJS = $(SRCS:.cpp=.o)
# EXEC = test_run

# # Target to build the executable
# $(EXEC): $(OBJS)
# 	$(CXX) $(OBJS) -o $(EXEC) $(LDFLAGS)

# # Rule to compile .cpp files into .o files
# %.o: %.cpp dynamic_array.h
# 	$(CXX) $(CXXFLAGS) -c $< -o $@

# # Rule to run the tests
# test: $(EXEC)
# 	./$(EXEC)

# # Clean up build artifacts
# clean:
# 	rm -f $(OBJS) $(EXEC)
