SHELL = /bin/bash
CXX = g++
CXXFLAGS = -std=c++17 -I/opt/homebrew/Cellar/googletest/1.15.2/include -Wall -Wextra -fprofile-arcs -ftest-coverage
LDFLAGS = -L/opt/homebrew/Cellar/googletest/1.15.2/lib -lgtest -lgtest_main -pthread -fprofile-arcs -ftest-coverage
SRCS = dynamic_array_test.cpp
OBJS = $(SRCS:.cpp=.o)
EXEC = test_run
COV_DIR = coverage_report
TEST_FILE = dynamic_array_test.cpp


# List of test cases for Google Test (formatted for filtering)
TEST_CASES = \
	DynamicArrayTest.InitialSizeIsZero \
	DynamicArrayTest.PushBackIncreasesSize \
	DynamicArrayTest.CapacityDoublesWhenFull \
	DynamicArrayTest.ElementsAreCorrectlyAdded \
	DynamicArrayTest.PopBackDecreasesSize \
	DynamicArrayTest.AccessOutOfBoundsThrowsException \
	DynamicArrayTest.ClearResetsSize

# Target to build the executable
$(EXEC): $(OBJS) dynamic_array.h
	$(CXX) $(OBJS) -o $(EXEC) $(LDFLAGS)

# Rule to compile .cpp files into .o files
%.o: %.cpp dynamic_array.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Rule to run individual tests
test: $(EXEC)

	for test in $(TEST_CASES); do \
		git add .; \
		git commit -m "Testing $$test"; \
		git push; \
		make $(EXEC); \
		./$(EXEC) --gtest_filter=$$test; \
		bash <(curl -s https://codecov.io/bash) -t 5711eb10-0699-4268-89c9-3d132dbc5dfe; \
	done

# Clean up build artifacts and coverage data
clean:
	rm -f $(OBJS) $(EXEC) *.gcno *.gcda *.gcov
	rm -rf $(COV_DIR)



# # Variables
# SHELL = /bin/bash
# CXX = g++
# CXXFLAGS = -std=c++17 -I/opt/homebrew/Cellar/googletest/1.15.2/include -Wall -Wextra -fprofile-arcs -ftest-coverage
# LDFLAGS = -L/opt/homebrew/Cellar/googletest/1.15.2/lib -lgtest -lgtest_main -pthread -fprofile-arcs -ftest-coverage
# SRCS = dynamic_array_test.cpp
# OBJS = $(SRCS:.cpp=.o)
# EXEC = test_run
# COV_DIR = coverage_report
# TEST_FILE = dynamic_array_test.cpp
# TEST_OUTPUT = test_output.cpp

# # List of test cases (exact syntax used in the tests)
# TEST_CASES = "TEST_F(DynamicArrayTest, InitialSizeIsZero)" "TEST_F(DynamicArrayTest, PushBackIncreasesSize)"

# # Target to build the executable
# $(EXEC): $(OBJS) dynamic_array.h
# 	$(CXX) $(OBJS) -o $(EXEC) $(LDFLAGS)

# # Rule to compile .cpp files into .o files
# %.o: %.cpp dynamic_array.h
# 	$(CXX) $(CXXFLAGS) -c $< -o $@

# # Target for toggling test comments
# TEST_CASES = "TEST_F(DynamicArrayTest, InitialSizeIsZero)" "TEST_F(DynamicArrayTest, PushBackIncreasesSize)" "TEST_F(DynamicArrayTest, CapacityDoublesWhenFull)" "TEST_F(DynamicArrayTest, ElementsAreCorrectlyAdded)" "TEST_F(DynamicArrayTest, PopBackDecreasesSize)" "TEST_F(DynamicArrayTest, AccessOutOfBoundsThrowsException)" "TEST_F(DynamicArrayTest, ClearResetsSize)" #"TEST_F(DynamicArrayTest, CustomTypeWorks)"
# TEST_FILE = dynamic_array_test.cpp
# TEST_OUTPUT = test_output.cpp

# test_comments:
# 	previous_test=""; \
# 	for test in $(TEST_CASES); do \
# 		sed -i '' "/^\/\/ *$$test *{/,/^ *}/s|^// *||" $(TEST_FILE); \
# 		if [ -n "$$previous_test" ]; then \
# 			sed -i '' "/^ *$$previous_test *{/,/^ *}/s|^ *|// |" $(TEST_FILE); \
# 		fi; \
# 		previous_test="$$test"; \
# 		cp $(TEST_FILE) $(TEST_OUTPUT); \
# 	done
# clean:
# 	rm -f $(OBJS) $(EXEC) *.gcno *.gcda *.gcov
# 	rm -rf $(COV_DIR)
# 	rm -f $(TEST_OUTPUT)
