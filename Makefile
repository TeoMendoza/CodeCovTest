# Variables
SHELL = /bin/bash
CXX = g++
CXXFLAGS = -std=c++17 -I/opt/homebrew/Cellar/googletest/1.15.2/include -Wall -Wextra -fprofile-arcs -ftest-coverage
LDFLAGS = -L/opt/homebrew/Cellar/googletest/1.15.2/lib -lgtest -lgtest_main -pthread -fprofile-arcs -ftest-coverage
SRCS = dynamic_array_test.cpp
OBJS = $(SRCS:.cpp=.o)
EXEC = test_run
CODECOV_TOKEN = 5711eb10-0699-4268-89c9-3d132dbc5dfe  # Your Codecov token

# Test cases (list the names of your individual test cases here)
TEST_CASES = DynamicArrayTest.InitialSizeIsZero #DynamicArrayTest.PushBackIncreasesSize

# Default target to build the executable
$(EXEC): $(OBJS) dynamic_array.h
	$(CXX) $(OBJS) -o $(EXEC) $(LDFLAGS)

# Rule to compile .cpp files into .o files
%.o: %.cpp dynamic_array.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Rule to run each test case individually and upload coverage to Codecov
run_test_%: $(EXEC)
	./$(EXEC) --gtest_filter=$*                  # Run individual test function
	bash <(curl -s https://codecov.io/bash) -t $(CODECOV_TOKEN)   # Upload the coverage to Codecov

# Loop through each test case
test: $(TEST_CASES:%=run_test_%)

# Clean up build artifacts and coverage data
clean:
	rm -f $(OBJS) $(EXEC) *.gcno *.gcda *.gcov
	rm -rf $(COV_DIR)  # Optionally clean up coverage reports


# Variables
# SHELL = /bin/bash
# CXX = g++
# CXXFLAGS = -std=c++17 -I/opt/homebrew/Cellar/googletest/1.15.2/include -Wall -Wextra -fprofile-arcs -ftest-coverage
# LDFLAGS = -L/opt/homebrew/Cellar/googletest/1.15.2/lib -lgtest -lgtest_main -pthread -fprofile-arcs -ftest-coverage
# SRCS = dynamic_array_test.cpp
# OBJS = $(SRCS:.cpp=.o)
# EXEC = test_run
# COV_DIR = coverage_report

# # Target to build the executable
# $(EXEC): $(OBJS) dynamic_array.h
# 	$(CXX) $(OBJS) -o $(EXEC) $(LDFLAGS)

# # Rule to compile .cpp files into .o files
# %.o: %.cpp dynamic_array.h
# 	$(CXX) $(CXXFLAGS) -c $< -o $@

# # Rule to run the tests and generate coverage data

# test: $(EXEC)
# 	./$(EXEC)                            # Run the tests to generate coverage data
# 	bash <(curl -s https://codecov.io/bash) -t 5711eb10-0699-4268-89c9-3d132dbc5dfe

# # Clean up build artifacts and coverage data
# clean:
# 	rm -f $(OBJS) $(EXEC) *.gcno *.gcda *.gcov
# 	rm -rf $(COV_DIR)  # Optionally clean up coverage reports


