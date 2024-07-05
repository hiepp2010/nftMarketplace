import { Blockchain, SandboxContract, TreasuryContract } from '@ton/sandbox';
import { toNano } from '@ton/core';
import { NftStake } from '../wrappers/NftStake';
import '@ton/test-utils';

describe('NftStake', () => {
    let blockchain: Blockchain;
    let deployer: SandboxContract<TreasuryContract>;
    let nftStake: SandboxContract<NftStake>;

    beforeEach(async () => {
        blockchain = await Blockchain.create();

        nftStake = blockchain.openContract(await NftStake.fromInit());

        deployer = await blockchain.treasury('deployer');

        const deployResult = await nftStake.send(
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
            to: nftStake.address,
            deploy: true,
            success: true,
        });
    });

    it('should deploy', async () => {
        // the check is done inside beforeEach
        // blockchain and nftStake are ready to use
    });
});
