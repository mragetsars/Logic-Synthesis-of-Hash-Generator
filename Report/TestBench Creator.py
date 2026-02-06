import sys

# --- داده‌های ورودی ---

# لیست ثابت‌ها (Constants) که دادید
raw_constants = """
78 56 db ee af 2a 13 01
d8 af b1 be 22 93 8e 21
62 40 51 aa 5d 53 81 c8
e6 d6 87 ed 05 f8 d9 8a
42 81 22 0c 44 a9 60 70
c6 fa 85 05 39 e5 f8 65
44 97 a7 39 c3 92 7d d1
4f e0 14 a1 82 35 bb 91
"""
# تبدیل رشته ثابت‌ها به لیست اعداد صحیح
constant_values = [int(x, 16) for x in raw_constants.split()]

# پیام ورودی (M)
# massage = [df, 01, f0, b7]
M_values = [0xdf, 0x01, 0xf0, 0xb7]

# -----------------------

# حافظه برای نگهداری متغیرها
variables = {}

# حافظه برای آرایه‌ها (از پیش پر شده با مقادیر بالا)
arrays = {
    'M': {i: val for i, val in enumerate(M_values)},
    'constant': {i: val for i, val in enumerate(constant_values)}
}

def to_hex(val):
    """تبدیل عدد به رشته هگز دو رقمی"""
    if val is None:
        return "Undefined"
    return f"0x{val:02x}"

def get_var(name):
    """گرفتن مقدار متغیر ساده. اگر نباشد، از کاربر می‌گیرد."""
    if name not in variables:
        val_str = input(f" >> Input required: Enter hex value for '{name}' (e.g. 0xFF): ")
        try:
            variables[name] = int(val_str, 16)
        except ValueError:
            print("Invalid hex input. Defaulting to 0x00")
            variables[name] = 0
    return variables[name]

def get_array_item(arr_name, index):
    """گرفتن مقدار از آرایه. الان دیگه از دیکشنری پر شده می‌خونه."""
    # اگر به هر دلیلی اندیس خارج از لیست بود، ارور نده و بپرس (محض اطمینان)
    if index not in arrays[arr_name]:
        val_str = input(f" >> Input required: Enter hex value for {arr_name}[{index}]: ")
        try:
            arrays[arr_name][index] = int(val_str, 16)
        except ValueError:
            arrays[arr_name][index] = 0
    return arrays[arr_name][index]

def set_var(name, value):
    """تنظیم مقدار متغیر و اعمال ماسک 8 بیتی"""
    variables[name] = value & 0xFF
    # برای اینکه خروجی شلوغ نشه، آپدیت‌های میانی رو کامنت کردم، اگه خواستی آن-کامنت کن
    # print(f"    [Update] {name} := {to_hex(variables[name])}")

def bit(val, n):
    """گرفتن بیت nام"""
    return (val >> n) & 1

def print_line(line_desc):
    """چاپ خطی که قرار است اجرا شود"""
    print(f"  Executing: {line_desc}")

# --- شروع شبیه‌سازی ---

print("--- Start of Simulation ---")

# مقداردهی اولیه متغیرهای اصلی
variables['a0'] = 0x01
variables['b0'] = 0x89
variables['c0'] = 0xfe
variables['d0'] = 0x76

variables['A'] = variables['a0']
variables['B'] = variables['b0']
variables['C'] = variables['c0']
variables['D'] = variables['d0']

print(f"Initial State: A={to_hex(variables['A'])}, B={to_hex(variables['B'])}, C={to_hex(variables['C'])}, D={to_hex(variables['D'])}")
print("-" * 60)

# حلقه اصلی
for i in range(64):
    # لاجیک محاسبه F بر اساس بازه i
    A = get_var('A')
    B = get_var('B')
    C = get_var('C')
    D = get_var('D')
    
    F = 0
    logic_str = ""
    if 0 <= i <= 15:
        F = (B & C) | ((~B & 0xFF) & D)
        logic_str = "(B & C) | (~B & D)"
    elif 16 <= i <= 31:
        F = (D & B) | ((~D & 0xFF) & C)
        logic_str = "(D & B) | (~D & C)"
    elif 32 <= i <= 47:
        F = B ^ C ^ D
        logic_str = "B ^ C ^ D"
    elif 48 <= i <= 63:
        F = C ^ (B | (~D & 0xFF))
        logic_str = "C ^ (B | ~D)"
    
    set_var('F', F)

    # x := i
    set_var('x', i)
    
    # تکرار ۶ باره (Scramble کردن x)
    x = get_var('x')
    for _ in range(6):
        b5 = bit(x, 5)
        b3 = bit(x, 3)
        b1 = bit(x, 1)
        fb = b5 ^ b3 ^ b1
        x = ((x << 1) | fb) & 0xFF
    set_var('x', x)
    
    # محاسبه rnd
    x = get_var('x')
    rnd = (bit(x, 5) << 1) | bit(x, 4)
    set_var('rnd', rnd)

    # خط اصلی آپدیت F
    # F := F + A + constant[i] + M[rnd]
    curr_F = get_var('F')
    curr_A = get_var('A')
    curr_K = get_array_item('constant', i)
    curr_M = get_array_item('M', rnd)
    
    new_F = (curr_F + curr_A + curr_K + curr_M) & 0xFF
    set_var('F', new_F)

    # شیفت دادن متغیرها
    variables['A'] = variables['D']
    variables['D'] = variables['C']
    variables['C'] = variables['B']
    
    # آپدیت پیچیده B
    # B := B + F[upper] * F[lower]
    curr_B = get_var('B')
    curr_F = get_var('F') # مقدار جدید F
    
    f_upper = (curr_F >> 4) & 0xF
    f_lower = curr_F & 0xF
    
    product = f_upper * f_lower
    new_B = (curr_B + product) & 0xFF
    
    variables['B'] = new_B
    
    # چاپ وضعیت در پایان هر دور
    print(f"i={i:02} | K={to_hex(curr_K)} M[{rnd}]={to_hex(curr_M)} | State: A={to_hex(variables['A'])} B={to_hex(variables['B'])} C={to_hex(variables['C'])} D={to_hex(variables['D'])}")

print("-" * 60)
print("--- Final Result ---")
digest = f"{to_hex(variables['A'])}{to_hex(variables['B'])}{to_hex(variables['C'])}{to_hex(variables['D'])}"
print(f"Digest: {digest.replace('0x', '')}")