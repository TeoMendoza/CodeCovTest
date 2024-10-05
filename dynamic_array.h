#ifndef DYNAMIC_ARRAY_H
#define DYNAMIC_ARRAY_H

#include <cstddef>
#include <stdexcept>

template <typename T>
class DynamicArray {
private:
    T* data_;         // Pointer to the dynamic array
    size_t size_;     // Current number of elements in the array
    size_t capacity_; // Maximum capacity of the array

    // Private function to resize the array when needed
    void Resize(size_t newCapacity) {
        T* newData = new T[newCapacity];
        for (size_t i = 0; i < size_; ++i) {
            newData[i] = data_[i];
        }
        delete[] data_; // Free the old memory
        data_ = newData;
        capacity_ = newCapacity;
    }

public:
    // Constructor
    DynamicArray(size_t initialCapacity = 2)
        : size_(0), capacity_(initialCapacity) {
        data_ = new T[capacity_];
    }

    // Destructor
    ~DynamicArray() {
        delete[] data_;
    }

    // Return the current size of the array
    size_t GetSize() const {
        return size_;
    }

    // Return the current capacity of the array
    size_t GetCapacity() const {
        return capacity_;
    }

    // Add an element to the end of the array
    void PushBack(const T& element) {
        if (size_ == capacity_) {
            Resize(capacity_ * 2); // Double the capacity if the array is full
        }
        data_[size_++] = element;
    }

    // Remove the last element of the array
    void PopBack() {
        if (size_ > 0) {
            --size_;
        }
    }

    // Access an element by index (read-only)
    const T& operator[](size_t index) const {
        if (index >= size_) {
            throw std::out_of_range("Index out of bounds");
        }
        return data_[index];
    }

    // Access an element by index (read/write)
    T& operator[](size_t index) {
        if (index >= size_) {
            throw std::out_of_range("Index out of bounds");
        }
        return data_[index];
    }

    // Clear the array
    void Clear() {
        size_ = 0;
    }
};

#endif // DYNAMIC_ARRAY_H
