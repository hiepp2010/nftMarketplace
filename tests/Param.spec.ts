import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { toNano } from '@ton/core';
import { Param } from '../wrappers/Param';
import '@ton/test-utils';

describe('Param', () => {
    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let param: SandboxContract<Param>;

    beforeEach(async () => {
        blockchain = await Blockchain.create();

        param = blockchain.openContract(await Param.fromInit());

        deployer = await blockchain.treasury('deployer');

        const deployResult = await param.send(
            deployer.getSender(),
            {
                value: toNano('0.05'),
            },
            {
                $$type: 'Deploy',
                queryId: 0n,
            }
        );

        expect(deployResult.transactions).toHaveTransaction({
            from: deployer.address,
            to: param.address,
            deploy: true,
            success: true,
        });
    });

    it('should deploy', async () => {
        // the check is done inside beforeEach
        // blockchain and param are ready to use
    });
});
