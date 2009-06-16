require 'test_helper'

include D2S3::Signature

class SignatureTest < Test::Unit::TestCase
  should "return correct core_sha1 values" do
    str = "abc"
    assert [-519653305, -1566383753, -2070791546, -753729183, -204968198], core_sha1(str2binb(str), str.length)
  end

  should "return correct str2binb values" do
    assert [1718578976, 1650553376, 1751480608, 1952998770, 1694498816],  str2binb('foo bar hey there')
  end

  should "return correct hex_sha1 value" do
    assert "a9993e364706816aba3e25717850c26c9cd0d89d", hex_sha1("abc")
  end

  should "return correct b64_hmac_sha1 value" do
    assert "frFXMR9cNoJdsSPnjebZpBhUKzI=", b64_hmac_sha1("foo", "abc")
  end

  context "with num=1732584193 and cnt=5" do
    setup do
      @num = 1732584193
      @cnt = 5
    end

    should "return correct roll value" do
      assert -391880660, rol(@num, @cnt)
    end

    should "return correct safe_add value" do
      assert -519653305, safe_add(2042729798, @num)
    end

    should "return correct js_shl value" do
      assert -391880672, js_shl(@num, @cnt)
    end

    should "return correct js_shr_zf value" do
      assert 12, js_shr_zf(@num, 32 - @cnt)
    end

    should "return correct sha1_ft value" do
      assert -1732584194, sha1_ft(0, -271733879, -1732584194, 271733878)
    end

    should "return correct sha1_kt value" do
      assert 1518500249, sha1_kt(0)
    end

    should "return correct safe_add value" do
      assert 286718899, safe_add(safe_add(rol(@num, @cnt), sha1_ft(0, -271733879, -1732584194, 271733878)), safe_add(safe_add(-1009589776, 1902273280), sha1_kt(0)))
    end
  end
end
