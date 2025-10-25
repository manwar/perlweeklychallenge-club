import numpy as np
import jax
import jax.numpy as jnp
import tensorflow as tf
import torch


def check_order(lst):
    return [c for c, (a, b) in enumerate(zip(lst, sorted(lst))) if a != b]


# NumPy Solution
def check_order_np(lst):
    l = np.array(lst)
    return np.where(l != sorted(l))[0]


def check_order_jax(lst):
    l = jnp.array(lst)
    return jnp.where(l != jnp.sort(l))[0]


# @jax.jit
# def check_order_jax_jit(lst):
#     l = jnp.array(lst)
#     return jnp.where(l != jnp.sort(l))[0]

# jax.errors.ConcretizationTypeError: Abstract tracer value encountered
#  where concrete value is expected: traced array with shape int32[]
# The size argument of jnp.nonzero must be statically specified to use
# jnp.nonzero within JAX transformations.


# TensorFlow Solution (CPU)
def check_order_tf(lst):
    l = tf.constant(lst)
    return tf.where(l != tf.sort(l))[:, 0].numpy()


# TensorFlow Solution (CUDA/GPU)
def check_order_tf_cuda(lst):
    with tf.device("/GPU:0"):
        l = tf.constant(lst)
        return tf.where(l != tf.sort(l))[:, 0].numpy()


# TensorFlow Function Solution (CPU)
@tf.function
def check_order_tf_fn(l):
    return tf.where(l != tf.sort(l))[:, 0]


# TensorFlow Function Solution (CUDA/GPU)
@tf.function
def check_order_tf_fn_cuda_impl(l):
    return tf.where(l != tf.sort(l))[:, 0]


def check_order_tf_fn_cuda(lst):
    with tf.device("/GPU:0"):
        l = tf.constant(lst)
        return check_order_tf_fn_cuda_impl(l).numpy()


# PyTorch Solution (CPU)
def check_order_torch(lst):
    l = torch.tensor(lst)
    return torch.where(l != torch.sort(l)[0])[0].numpy()


# PyTorch Solution (CUDA/GPU)
def check_order_torch_cuda(lst):
    l = torch.tensor(lst).cuda()
    return torch.where(l != torch.sort(l)[0])[0].cpu().numpy()


# PyTorch JIT Compile Solution (CPU)
@torch.jit.script
def check_order_torch_jit_impl(l):
    return torch.where(l != torch.sort(l)[0])[0]


def check_order_torch_jit(lst):
    l = torch.tensor(lst)
    return check_order_torch_jit_impl(l).numpy()


# PyTorch JIT Compile Solution (CUDA/GPU)
@torch.jit.script
def check_order_torch_jit_cuda_impl(l):
    return torch.where(l != torch.sort(l)[0])[0]


def check_order_torch_jit_cuda(lst):
    l = torch.tensor(lst).cuda()
    return check_order_torch_jit_cuda_impl(l).cpu().numpy()


# Tests
print(check_order([5, 2, 4, 3, 1]))  # [0, 2, 3, 4]
print(check_order([1, 2, 1, 1, 3]))  # [1, 3]
print(check_order([3, 1, 3, 2, 3]))  # [0, 1, 3]
print(check_order_np([5, 2, 4, 3, 1]))  # [0, 2, 3, 4]
print(check_order_np([1, 2, 1, 1, 3]))  # [1, 3]
print(check_order_np([3, 1, 3, 2, 3]))  # [0, 1, 3]
print(check_order_jax([5, 2, 4, 3, 1]))  # [0, 2, 3, 4]
print(check_order_jax([1, 2, 1, 1, 3]))  # [1, 3]
print(check_order_jax([3, 1, 3, 2, 3]))  # [0, 1, 3]
print(check_order_tf([5, 2, 4, 3, 1]))  # [0, 2, 3, 4]
print(check_order_tf([1, 2, 1, 1, 3]))  # [1, 3]
print(check_order_tf([3, 1, 3, 2, 3]))  # [0, 1, 3]
print(check_order_tf_fn(tf.constant([5, 2, 4, 3, 1])).numpy())  # [0, 2, 3, 4]
print(check_order_tf_fn(tf.constant([1, 2, 1, 1, 3])).numpy())  # [1, 3]
print(check_order_tf_fn(tf.constant([3, 1, 3, 2, 3])).numpy())  # [0, 1, 3]
print(check_order_torch([5, 2, 4, 3, 1]))  # [0, 2, 3, 4]
print(check_order_torch([1, 2, 1, 1, 3]))  # [1, 3]
print(check_order_torch([3, 1, 3, 2, 3]))  # [0, 1, 3]
print(check_order_torch_jit([5, 2, 4, 3, 1]))  # [0, 2, 3, 4]
print(check_order_torch_jit([1, 2, 1, 1, 3]))  # [1, 3]
print(check_order_torch_jit([3, 1, 3, 2, 3]))  # [0, 1, 3]

# CUDA/GPU Tests (requires CUDA-capable GPU)
if tf.config.list_physical_devices("GPU"):
    print("TensorFlow GPU available")
    print(check_order_tf_cuda([5, 2, 4, 3, 1]))  # [0, 2, 3, 4]
    print(check_order_tf_cuda([1, 2, 1, 1, 3]))  # [1, 3]
    print(check_order_tf_cuda([3, 1, 3, 2, 3]))  # [0, 1, 3]
    print(check_order_tf_fn_cuda([5, 2, 4, 3, 1]))  # [0, 2, 3, 4]
    print(check_order_tf_fn_cuda([1, 2, 1, 1, 3]))  # [1, 3]
    print(check_order_tf_fn_cuda([3, 1, 3, 2, 3]))  # [0, 1, 3]
else:
    print("TensorFlow GPU not available")

if torch.cuda.is_available():
    print("PyTorch CUDA available")
    print(check_order_torch_cuda([5, 2, 4, 3, 1]))  # [0, 2, 3, 4]
    print(check_order_torch_cuda([1, 2, 1, 1, 3]))  # [1, 3]
    print(check_order_torch_cuda([3, 1, 3, 2, 3]))  # [0, 1, 3]
    print(check_order_torch_jit_cuda([5, 2, 4, 3, 1]))  # [0, 2, 3, 4]
    print(check_order_torch_jit_cuda([1, 2, 1, 1, 3]))  # [1, 3]
    print(check_order_torch_jit_cuda([3, 1, 3, 2, 3]))  # [0, 1, 3]
else:
    print("PyTorch CUDA not available")
