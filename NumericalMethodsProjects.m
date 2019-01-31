clc;
close all;
clear all;

disp ('NUMERICAL METHODS PROJECT');

while true
    disp ('Enter 1 for Gauss Elimination Method');
    disp ('Enter 2 for Gauss Seidel Method');
    disp ('Enter 3 for Exiting');
    
    choice = input('Choice: ');
    
    switch choice
        case 1
            mainGaussElimination
            disp ('Press Enter key to continue...');
            pause
        case 2
            mainGaussSeidel
            pause
        case 3
            break
        otherwise
            disp('Invalid entry. Please try again.')
            disp ('Press Enter key to continue...');
            pause
    end
end

function mainGaussElimination
    n = input ('Enter the value of \''n\'' to create an n x (n + 1) matrix:\n');
    
    disp ('Enter the augmented matrix:');
    a = [];
    a = MatrixInput(a, n, n + 1);
    
    a = upper(a, n, n + 1);
    
    sol = [];
    sol = elimination(a, n, n + 1);
    
    for i = 1 : n
        X = sprintf('x%d = %d', i, sol(i));
        disp (X);
    end
end

function mainGaussSeidel
    n = input ('Enter the order of the matrix: ');
    
    disp ('Enter the coefficient matrix: ');
    a = [];
    a = MatrixInput(a, n, n);
    
    disp ('Enter the right hand side vector:');
    b = [];
    b = MatrixInput(b, n);
    
    accuracy = input ('Enter the desired accuracy: ');
    
    if diagonallyDominant(a, n, n) == false
        disp ('Error. The matrix is not diagonally dominant.');
        disp ('Please try again');
        return
    end
    
    if diagonallyDominant(a, n, n) == true
        disp ('The matrix is diagonally dominant.');
    end
    
    x = zeros(1,n);
    
    sol = GaussSeidel(a, b, n, accuracy, x);
    
    disp ('The solution of the system is');
    disp (sol);
end

function A = MatrixInput(A, rows, columns)
    
    % 2D Array input
    if nargin == 3
        for i = 1 : rows
                for j = 1 : columns
                    A(i,j) = input (sprintf('A(%d, %d): ', i, j));
                end
        end
        
    % 1D Array input
    elseif nargin == 2
        for i = 1 : rows
            A(i) = input (sprintf('A(%d): ', i));
        end
    end
end

function A = upper(A, rows, columns)
    for j = 1 : columns
            for i = 1:rows
                if i > j
                    multiplicand = A(i,j) / A(j,j);
                    
                    for k = 1 : columns
                        A(i,k) = A(i,k) - multiplicand * A(j,k);
                    end
                end
            end
    end
end

function x = elimination(A, rows, columns)
    x = zeros(1,rows);
    
    x(rows) = A(rows,columns) / A(rows,columns - 1);
    
    for i = rows : -1 : 1
        sum = 0.0;
        for j = columns - 1 : -1 : i + 1
            sum = sum + A(i,j) * x(j);
        end
        x(i) = (A(i,columns) - sum) / A(i,i);
    end
end

function x0 = GaussSeidel(A, B, size, accuracy, x)
    x0 = zeros(1, size);
    accuracyObtained = false;
    
    while accuracyObtained == false
        for i = 1 : size
            currentError = 0.0;
            x(i) = x0(i);
            sum = 0.0;
            for j = 1 : size
                if i == j
                    continue
                end
                sum = sum + A(i,j) * x0(j);
            end
            
            x0(i) = (B(i) - sum) / A(i,i);
            
            maxError = abs(x(i) - x0(i));
            if maxError > currentError
                currentError = maxError;
            end
            
            if currentError < accuracy
                accuracyObtained = true;
            end
        end
    end
end

function condition = diagonallyDominant(A, rows, columns)
    for i = 1 : rows
        rowSum = 0.0;
        for j = 1 : columns
            if i == j
                continue
            end
            rowSum = rowSum + abs(A(i,j));
        end
        if abs(A(i,i)) < rowSum
            condition = false;
            return
        end
    end
    
    condition = true;
end