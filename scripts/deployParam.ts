import { toNano } from '@ton/core';
import { Param } from '../wrappers/Param';
import { NetworkProvider } from '@ton/blueprint';

export async function run(provider: NetworkProvider) {
    const param = provider.open(await Param.fromInit());

    await param.send(
        provider.sender(),
        {
            value: toNano('0.05'),
        },
        {
            $$type: 'Deploy',
            queryId: 0n,
        }
    );

    await provider.waitForDeploy(param.address);

    // run methods on `param`
}
