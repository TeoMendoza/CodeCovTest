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
	DynamicArrayTest.PushBackIncreasesSize \
	# DynamicArrayTest.InitialSizeIsZero \
	# DynamicArrayTest.CapacityDoublesWhenFull \
	# DynamicArrayTest.ElementsAreCorrectlyAdded \
	# DynamicArrayTest.PopBackDecreasesSize \
	# DynamicArrayTest.AccessOutOfBoundsThrowsException \
	# DynamicArrayTest.ClearResetsSize

COVERAGE_THRESHOLDS := 15 


# Target to build the executable
$(EXEC): $(OBJS) dynamic_array.h
	$(CXX) $(OBJS) -o $(EXEC) $(LDFLAGS)

# Rule to compile .cpp files into .o files
%.o: %.cpp dynamic_array.h
	$(CXX) $(CXXFLAGS) -c $< -o $@

test: $(EXEC)
	for test in $(TEST_CASES); do \
		make clean; \
		make $(EXEC); \
		./$(EXEC) --gtest_filter=$$test; \
		export CODECOV_ENV=$$test; \
		git add *.yml *.gcno *.gcda; \
		if ! git diff --cached --quiet; then \
			git commit -m "Coverage for test: $$test"; \
			git push; \
		fi; \
		bash <(curl -s https://codecov.io/bash) -t 5711eb10-0699-4268-89c9-3d132dbc5dfe -y codecov.yml; \
		sleep 5; \
	done
	make clean; \

fetch-report:
	@echo "Fetching JSON coverage report for the latest commit with dynamic_array flag..."
	@REPO_SLUG="TeoMendoza/CodeCovTest"  # Replace with your actual repo slug in 'username/repo' format
	@COMMIT_SHA=$$(git rev-parse HEAD)  # Automatically fetch the latest commit SHA
	@API_TOKEN=  # Replace with your actual API token
	@curl -s --request GET \
		--url "https://api.codecov.io/api/v2/github/$${REPO_SLUG}/commits/$${COMMIT_SHA}/report/?flag=dynamic_array" \
		--header "accept: application/json" \
		--header "authorization: Bearer $${API_TOKEN}" \
		-o "coverage_report_$${COMMIT_SHA}.json"
	@echo "Coverage report saved as coverage_report_$${COMMIT_SHA}.json"

clean:
	rm -f $(OBJS) $(EXEC) *.gcno *.gcda *.gcov
	rm -rf $(COV_DIR)




edit-yml:
	@count=$(COUNT); \
	thresholds=($(COVERAGE_THRESHOLDS)); \
	COVERAGE_THRESHOLD=$${thresholds[$$count]}; \
	echo "Setting coverage threshold to $$COVERAGE_THRESHOLD%"; \
	sed -i '' "s/target: [0-9]*%/target: $$COVERAGE_THRESHOLD%/" codecov.yml; \
	echo "Updated codecov.yml content:"; \
	cat codecov.yml