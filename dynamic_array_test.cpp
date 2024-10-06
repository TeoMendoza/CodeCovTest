#include <gtest/gtest.h>
#include "dynamic_array.h"

class DynamicArrayTest : public ::testing::Test {
protected:
    void SetUp() override {}
    void TearDown() override {}
};

// TEST_F(DynamicArrayTest, InitialSizeIsZero) {
// DynamicArray<int> arr;
// EXPECT_EQ(arr.GetSize(), 0);
// }

// TEST_F(DynamicArrayTest, PushBackIncreasesSize) {
// DynamicArray<int> arr;
// arr.PushBack(10);
// EXPECT_EQ(arr.GetSize(), 1);
// arr.PushBack(20);
// EXPECT_EQ(arr.GetSize(), 2);
// }

// TEST_F(DynamicArrayTest, CapacityDoublesWhenFull) {
// DynamicArray<int> arr(2);
// EXPECT_EQ(arr.GetCapacity(), 2);

// arr.PushBack(10);
// arr.PushBack(20);
// EXPECT_EQ(arr.GetCapacity(), 2);

// arr.PushBack(30); 
// EXPECT_EQ(arr.GetCapacity(), 4);
// }

// TEST_F(DynamicArrayTest, ElementsAreCorrectlyAdded) {
// DynamicArray<int> arr;
// arr.PushBack(10);
// arr.PushBack(20);
// EXPECT_EQ(arr[0], 10);
// EXPECT_EQ(arr[1], 20);
// }

// TEST_F(DynamicArrayTest, PopBackDecreasesSize) {
// DynamicArray<int> arr;
// arr.PushBack(10);
// arr.PushBack(20);
// EXPECT_EQ(arr.GetSize(), 2);

// arr.PopBack();
// EXPECT_EQ(arr.GetSize(), 1);

// arr.PopBack();
// EXPECT_EQ(arr.GetSize(), 0);
// }


// TEST_F(DynamicArrayTest, AccessOutOfBoundsThrowsException) {
// DynamicArray<int> arr;
// arr.PushBack(10);
// EXPECT_THROW(arr[1], std::out_of_range);
// }


// TEST_F(DynamicArrayTest, ClearResetsSize) {
// DynamicArray<int> arr;
// arr.PushBack(10);
// arr.PushBack(20);
// EXPECT_EQ(arr.GetSize(), 2);
// 
// arr.Clear();
// EXPECT_EQ(arr.GetSize(), 0);
// }


int main(int argc, char **argv) {
   ::testing::InitGoogleTest(&argc, argv);
   return RUN_ALL_TESTS();
}
