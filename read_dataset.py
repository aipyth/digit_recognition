import numpy as np
import struct


def read_images(filename):
    """
    Read the binary images file provided from
    http://yann.lecun.com/exdb/mnist/"
    """
    with open(filename, 'rb') as f:
        # first four integers (assume 4 bytes each) are:
        # - magic number (2051)
        # - number of images
        # - number of rows in an image
        # - number of cols in an image
        magic, num, rows, cols = struct.unpack(">IIII", f.read(16))
        images = np.fromfile(f, dtype=np.uint8).reshape(num, rows, cols)
    return images


def read_labels(filename):
    """
    Read the labels of the images file provided from
    http://yann.lecun.com/exdb/mnist/"
    """
    with open(filename, 'rb') as f:
        # first two integers (assume 4 bytes each) are:
        # - magic number (2049)
        # - number of items
        magic, num = struct.unpack(">II", f.read(8))
        # after that we for all the unsigned bytes of
        # the labels
        labels = np.fromfile(f, dtype=np.uint8)
    return labels


if __name__ == "__main__":
    train_images = read_images('./train-images.idx3-ubyte')
    train_labels = read_labels('./train-labels.idx1-ubyte')
    print("Train dataset size: ", train_images.shape)
    print("Number of labels: ", train_labels.shape)
