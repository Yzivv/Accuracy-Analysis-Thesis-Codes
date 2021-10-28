function out = test_a(x)
    out = 0;
    if 0 <= x && x < 0.25
        out = 12;
    end
    if 0.25 <= x && x < 0.5
        out = 1234;
    end
    if 0.5 <= x && x < 0.75
        out = 333;
    end
    if 0.75 <= x && x <= 1.00
        out = 221;
    end
end