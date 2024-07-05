import { CompilerConfig } from '@ton/blueprint';

export const compile: CompilerConfig = {
    lang: 'tact',
    target: 'contracts/crawl_event.tact',
    options: {
        debug: true,
    },
};
