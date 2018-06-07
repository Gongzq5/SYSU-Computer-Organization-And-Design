/*
 * @Time 2018/06/05 16:33
 * @Author Zequn Gong
 * 
 * Compile MIPS code to binary code
 */
 
#include <stdio.h>
#include <memory.h>
#include <string.h>
#include <stdlib.h>
#include <iostream>
#include <map>
using namespace std;

std::string instruction;

/*
    // // If you want single one, just change to use this map.
    // std::map<string, string> op2code = {
    //     {"add", "000000"},
    //     {"sub", "000010"},
    //     {"addi", "000001"},
    //     {"or", "010010"},
    //     {"and", "010001"},
    //     {"ori", "010000"},
    //     {"sll", "011000"},
    //     {"slt", "100110"},
    //     {"slti", "011011"},
    //     {"beq", "110000"},
    //     {"bne", "110001"},
    //     {"sltiu", "100111"},
    //     {"sw", "100110"},
    //     {"lw", "100111"},
    //     {"bltz", "110110"},
    //     {"j", "111000"},
    //     {"jr", "111001"},
    //     {"jal", "111010"},
    //     {"halt", "111111"}
    // };
 */

std::map<string, string> op2code = {
    {"add", "000000"},
    {"sub", "000001"},
    {"addi", "000010"},
    {"or", "010000"},
    {"and", "010001"},
    {"ori", "010010"},
    {"sll", "011000"},
    {"slt", "100110"},
    {"slti", "011011"},
    {"bne", "110001"},
    {"sltiu", "100111"},
    {"sw", "110000"},
    {"lw", "110001"},
    {"beq", "110100"},
    {"bltz", "110110"},
    {"j", "111000"},
    {"jr", "111001"},
    {"jal", "111010"},
    {"halt", "111111"}
};

/*
 * Type introducation
 * 1: op rd rs rt
 * 2: op rt rs immediate
 * 3: op rd rt sa
 * 4: op rt immediate(rs)
 * 5: op rs rt immediate
 * 6: op rs immediate
 * 7: op addr
 * 8: op rs
 * 9: op null
 */

std::map<string, int> op2type = {
    {"add", 1},
    {"sub", 1},
    {"addi", 2},
    {"or", 1},
    {"and", 1},
    {"ori", 2},
    {"sll", 3},
    {"slt", 1},
    {"slti", 2},
    {"sltiu", 2},
    {"sw", 4},
    {"lw", 4},
    {"beq", 5},
    {"bne", 5},
    {"bltz", 6},
    {"j", 7},
    {"jr", 8},
    {"jal", 7},
    {"halt", 9}
};

void trim_last_16_from_32 (char* dest, char* source) {
    int begin = 16;
    for (int i=begin; i<begin+16; i++) {
        dest[i-begin] = source[i];
    }
    dest[16] = 0;
    return;
}

std::string convert() {

	std::string opCommand;
	std::cin >> opCommand;
	instruction = op2code[opCommand];
    if (opCommand == "") {
        return "wrong";
    }

    std::cerr << "[" << opCommand << "] over" << endl;

	int rs, rt, rd, sa, immediate;
    long long int addr;
	char tmps[6], tmpt[6], tmpd[6], tmpsa[6], tmpaddr[27], tmpimm_32[33];
	char rss[6], rts[6], rds[6], sas[6], immediates[17], addrs[27], immediates_32[33];

	int type = op2type[opCommand];

	switch (type) {
        // 1: op rd rs rt
		case 1:
			scanf(" $%d , $%d , $%d", &rd, &rs, &rt);
			ltoa(rd, tmpd, 2); ltoa(rt, tmpt, 2); ltoa(rs, tmps, 2);
			sprintf(rss, "%05s", tmps);
			sprintf(rds, "%05s", tmpd);
			sprintf(rts, "%05s", tmpt);
			instruction = instruction + rss + rts + rds + "00000" + "000000";
			break;
        // 2: op rt rs immediate
		case 2:
            scanf(" $%d , $%d , %d", &rt, &rs, &immediate);
            ltoa(rt, tmpt, 2); ltoa(rs, tmps, 2); ltoa(immediate, tmpimm_32, 2);
            sprintf(rts, "%05s", tmpt);
            sprintf(rss, "%05s", tmps);
            sprintf(immediates_32, "%032s", tmpimm_32);
            trim_last_16_from_32(immediates, immediates_32);
            instruction = instruction + rss + rts + immediates;
            break;        
		// 3: op rd rt sa
        case 3:
            scanf(" $%d , $%d , %d", &rd, &rt, &sa);
            ltoa(rd, tmpd, 2); ltoa(rt, tmpt, 2); ltoa(sa, tmpsa, 2);
            sprintf(rds, "%05s", tmpd);
            sprintf(rts, "%05s", tmpt);
            sprintf(sas, "%05s", tmpsa);
            instruction = instruction + "00000" + rts + rds + sas + "000000";
            break;
		// 4: op rt immediate(rs)
        case 4:
            scanf(" $%d , %d ( $%d )", &rt, &immediate, &rs);
            ltoa(rt, tmpt, 2); ltoa(immediate, tmpimm_32, 2); ltoa(rs, tmps, 2);
            sprintf(rts, "%05s", tmpt);
            sprintf(immediates_32, "%032s", tmpimm_32);
            trim_last_16_from_32(immediates, immediates_32);
            sprintf(rss, "%05s", tmps);
            instruction = instruction + rss + rts + immediates;
            break;
		// 5: op rs rt immediate
        case 5:
            scanf(" $%d , $%d , %d", &rs, &rt, &immediate);
            ltoa(rs, tmps, 2); ltoa(rt, tmpt, 2); ltoa(immediate, tmpimm_32, 2);
            sprintf(rss, "%05s", tmps);
            sprintf(rts, "%05s", tmpt);
            sprintf(immediates_32, "%032s", tmpimm_32);
            trim_last_16_from_32(immediates, immediates_32);
            instruction = instruction + rss + rts + immediates;
            break;
		// 6: op rs immediate
        case 6:
            scanf(" $%d , %d", &rs, &immediate);
            ltoa(rs, tmps, 2); ltoa(immediate, tmpimm_32, 2);
            sprintf(rss, "%05s", tmps);
            sprintf(immediates_32, "%016s", tmpimm_32);
            trim_last_16_from_32(immediates, immediates_32);
            instruction = instruction + rss + "00000" + immediates;
            break;
        // 7: op addr
		case 7:
            scanf("%x", &addr);
            addr /= 4;
            ltoa(addr, tmpaddr, 2);
            sprintf(addrs, "%026s", tmpaddr);
            instruction = instruction + addrs;
            break;
        // 8: op rs
		case 8:
            scanf("%d", &rs);
            ltoa(rs, tmps, 2);
            sprintf(rss, "%05s", tmps);
            instruction = instruction + rss + "00000" + "00000" + "000000";
            break;
        // 9: op null
		case 9:
            instruction = instruction + "00000000000000000000000000";
            break;
		default: break;
	};
	return instruction;
}

int main(void) {
	
    freopen("out.txt", "w", stdout);

    while (true) {
        if ("wrong" == convert()) {
            return 0;
        }
        cout << instruction << endl;    
    }
	
    return 0;
}