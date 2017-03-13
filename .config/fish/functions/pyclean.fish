function pyclean
    find . -type f -name "*.py[co]" -delete
    find . -type d -path '*/__pycache__/*' -delete
    find . -type d -name "__pycache__" -empty -delete
end
