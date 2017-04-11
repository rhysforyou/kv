defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, bucket} = KV.Bucket.start_link
    {:ok, bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3

    assert KV.Bucket.delete(bucket, "milk") == 3
    assert KV.Bucket.get(bucket, "milk") == nil
  end

  test "lists the keys it contains", %{bucket: bucket} do
    assert KV.Bucket.keys(bucket) == []

    KV.Bucket.put(bucket, "eggs", 6)
    KV.Bucket.put(bucket, "milk", 3)

    assert KV.Bucket.keys(bucket) == ["eggs", "milk"]
  end
end
