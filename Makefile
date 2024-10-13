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
	DynamicArrayTest.CapacityDoublesWhenFull \
	DynamicArrayTest.InitialSizeIsZero \
	# DynamicArrayTest.PushBackIncreasesSize \
	# DynamicArrayTest.ElementsAreCorrectlyAdded \
	# DynamicArrayTest.PopBackDecreasesSize \
	# DynamicArrayTest.AccessOutOfBoundsThrowsException \
	# DynamicArrayTest.ClearResetsSize

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
		sleep 10; \
		make $(EXEC); \
		./$(EXEC) --gtest_filter=$$test; \
		export CODECOV_ENV=$$test; \
		bash <(curl -s https://codecov.io/bash) -t 5711eb10-0699-4268-89c9-3d132dbc5dfe -Y codecov.yml; \
	done

# Clean up build artifacts and coverage data
clean:
	rm -f $(OBJS) $(EXEC) *.gcno *.gcda *.gcov
	rm -rf $(COV_DIR)



