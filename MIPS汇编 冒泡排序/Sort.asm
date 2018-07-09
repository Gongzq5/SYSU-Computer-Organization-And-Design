#####################################################
#                                                   #
#                Bubble Sort In Mips                #
#                                                   #
#####################################################

.text

.globl main
    swap:
        addi $sp, $sp, -12
        sw  $ra, 8($sp)
        sw  $a1, 4($sp)
        sw  $a0, 0($sp)

        lw  $t0, 0($a0)
        lw  $t1, 0($a1)

        sw  $t0, 0($a1)
        sw  $t1, 0($a0)

        addi $sp, $sp, 12
        jr  $ra

    main:
        
#################################   INPUT    ##################################
        
        la  $a0, inputHint          # 打印输入提示文字
        li  $v0, 4              
        syscall                 
        
        li  $v0, 5
        syscall
        move $s0, $v0               # s0保存数组大小

        la  $s1, array              # 获得数组首地址        
        move  $t1, $s1              # 标识了当前的数组位置
        move  $t0, $zero            # 作为循环变量i

        InputLoop:   
            la  $a0, inputTips
            li  $v0, 4        
            syscall                 # 输入提示

            li  $v0, 5              # 读取一个整数
            syscall                 
            sw  $v0, 0($t1)         # 存入当前数组位置上

            add $t0, $t0, 1         # 循环变量+1
            mul $t2, $t0, 4         # $(t2) = $(t0) * 4
            add $t1, $s1, $t2       # t1 = s1 + t2
                                    # 这是[字节数]*[循环变量]+[数组起始位置]

            blt $t0, $s0, InputLoop # 非10则继续循环

##############################  SORT ALGORITHM ################################
        
        la  $a0, WaitingMsg
        li  $v0, 4
        syscall

        move $t0, $zero                     # $t0 <=> i, i = 0
    
        FirstLoop:
            bge $t0, $s0, BreakFirst        # if (i>=size) break;

            addi $t1, $t0, 1                # int j = i + 1;
            
            sll $t2, $t0, 2                 # 左移2位
            add $t2, $t2, $s1               # $t2 = $t2*4 + $s1

            SecondLoop:
                bge $t1, $s0, BreakSecond   # if (j>=size) break;

                sll $t3, $t1, 2
                add $t3, $t3, $s1
                
                lw  $t4, 0($t2)
                lw  $t5, 0($t3)
                blt $t4, $t5, Swap          # if (array[i]<array[j]) swap
                j SecondLoopOver            # else jump to over
                Swap:                           
                    sw $t4, ($t3)
                    sw $t5, ($t2)
            
            SecondLoopOver:
                addi $t1, $t1, 1
                j SecondLoop
            
            BreakSecond:

        FirstLoopOver:
            addi $t0, $t0, 1
            j FirstLoop

        BreakFirst:

#############################       OUTPUT      ###############################
        
        la  $a0, outputHint     # 输出提示
        li  $v0, 4
        syscall

        move  $t1, $s1          # 标识了当前的数组位置
        move  $t0, $zero        # 作为循环变量i
    
        OutputLoop:        
            lw  $a0, 0($t1)         # 将当前数组元素放入a0        
            li  $v0, 1              # 调用1号功能-输出一个int
            syscall                 

            la  $a0, sperate        # 输出一个空格
            li  $v0, 4 
            syscall

            addu $t0, 1             # 循环变量+1
            mul $t2, $t0, 4         # $(t2) = $(t0) * 4
            addu  $t1, $s1, $t2     # t1 = t1 + t2
                                    # 这是[字节数]*[循环变量]+[数组起始位置]

            blt $t0, $s0, OutputLoop # 非size则继续循环


.data
    array: 
        .space 40    

    inputHint:
        .asciiz "How many numbers do you want to sort?\n"
    inputTips:
        .asciiz "Please input a number.\n"
    outputHint:
        .asciiz "After sort, the numbers are: \n"
    WaitingMsg:
        .asciiz "Sorting...\n"
    sperate:
        .asciiz " "

##################C++ 排序部分源代码###############################
    #                                  
    #     int i=0;                                      
    #     while (1) {                                       
    #         if (i==10) break;                                     
    #         int j=i+1;                                        
    #         while (1) {                                       
    #             if (j==10) break;                                     
    #             if (array[i]<array[j]) {                                      
    #                 swap(array[i],array[j]);                                      
    #             }                                     
    #             j++;                                      
    #         }                                     
    #         // breakSecond:                                       
    #         i++;                                      
    #     }                                     
    #     // breakFirst:                                        
    #                                        
    ################################################