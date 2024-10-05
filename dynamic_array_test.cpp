#include <gtest/gtest.h>
#include "dynamic_array.h"

// Test fixture for the DynamicArray class
class DynamicArrayTest : public ::testing::Test {
protected:
    void SetUp() override {}
    void TearDown() override {}
};

// Test that an empty array has size 0
TEST_F(DynamicArrayTest, InitialSizeIsZero) {
    DynamicArray<int> arr;
    EXPECT_EQ(arr.GetSize(), 0);
}

// Test that adding an element increases the size
TEST_F(DynamicArrayTest, PushBackIncreasesSize) {
    DynamicArray<int> arr;
    arr.PushBack(10);
    EXPECT_EQ(arr.GetSize(), 1);
    arr.PushBack(20);
    EXPECT_EQ(arr.GetSize(), 2);
}

// Test that capacity doubles when array is full
TEST_F(DynamicArrayTest, CapacityDoublesWhenFull) {
    DynamicArray<int> arr(2);
    EXPECT_EQ(arr.GetCapacity(), 2);
    
    arr.PushBack(10);
    arr.PushBack(20);
    EXPECT_EQ(arr.GetCapacity(), 2);

    arr.PushBack(30); // This should trigger a resize
    EXPECT_EQ(arr.GetCapacity(), 4);
}

// Test that elements are correctly added
TEST_F(DynamicArrayTest, ElementsAreCorrectlyAdded) {
    DynamicArray<int> arr;
    arr.PushBack(10);
    arr.PushBack(20);
    EXPECT_EQ(arr[0], 10);
    EXPECT_EQ(arr[1], 20);
}

// Test that PopBack decreases the size
TEST_F(DynamicArrayTest, PopBackDecreasesSize) {
    DynamicArray<int> arr;
    arr.PushBack(10);
    arr.PushBack(20);
    EXPECT_EQ(arr.GetSize(), 2);

    arr.PopBack();
    EXPECT_EQ(arr.GetSize(), 1);

    arr.PopBack();
    EXPECT_EQ(arr.GetSize(), 0);
}

// Test that accessing out of bounds throws an exception
TEST_F(DynamicArrayTest, AccessOutOfBoundsThrowsException) {
    DynamicArray<int> arr;
    arr.PushBack(10);
    EXPECT_THROW(arr[1], std::out_of_range);
}

// Test clearing the array resets size to 0
// TEST_F(DynamicArrayTest, ClearResetsSize) {
//     DynamicArray<int> arr;
//     arr.PushBack(10);
//     arr.PushBack(20);
//     EXPECT_EQ(arr.GetSize(), 2);

//     arr.Clear();
//     EXPECT_EQ(arr.GetSize(), 0);
// }

// Test that an array with a custom type works
TEST_F(DynamicArrayTest, CustomTypeWorks) {
    struct CustomType {
        int x;
        CustomType() : x(0) {} // Add default constructor
        CustomType(int val) : x(val) {}
    };

    DynamicArray<CustomType> arr;
    arr.PushBack(CustomType(5));
    arr.PushBack(CustomType(10));
    EXPECT_EQ(arr[0].x, 5);
    EXPECT_EQ(arr[1].x, 10);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
