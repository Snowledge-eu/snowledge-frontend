"use client";

import { ChevronRight } from "lucide-react";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import Link from "next/link";

export function Banner5() {
  return (
    <div
      className="flex flex-col justify-center items-center gap-6 h-screen" // you can remove classes here - it's just for the wrapper
    >
      <Link
        href="#"
        className="flex pl-1 pr-2 border border-border h-11 box-border bg-background gap-2 items-center rounded-full hover:bg-muted w-fit shadow-sm"
        aria-label="View our 5,000+ customer testimonials"
      >
        <div 
          className="flex items-center -space-x-4"
          aria-hidden="true"
        >
          <Avatar className="size-9 border-2 border-background">
            <AvatarImage src="https://github.com/shadcn.png" alt="Customer avatar" />
            <AvatarFallback>CN</AvatarFallback>
          </Avatar>
          <Avatar className="size-9 border-2 border-background">
            <AvatarImage src="https://github.com/shadcn.png" alt="Customer avatar" />
            <AvatarFallback>CN</AvatarFallback>
          </Avatar>
          <Avatar className="size-9 border-2 border-background">
            <AvatarImage src="https://github.com/shadcn.png" alt="Customer avatar" />
            <AvatarFallback>CN</AvatarFallback>
          </Avatar>
        </div>
        <span className="text-sm font-medium text-muted-foreground">
          Loved by <span className="text-foreground">5K+ customers</span>
        </span>
        <ChevronRight 
          className="size-4 text-muted-foreground shrink-0" 
          aria-hidden="true"
        />
      </Link>

      <Link
        href="#"
        className="flex pl-1 pr-2 h-11 box-border border border-zinc-900 bg-zinc-900 gap-2 items-center rounded-full hover:bg-zinc-800 w-fit shadow-sm"
        aria-label="View our 5,000+ customer testimonials"
      >
        <div 
          className="flex items-center -space-x-4"
          aria-hidden="true"
        >
          <Avatar className="size-8 border-2 border-zinc-900">
            <AvatarImage src="https://github.com/shadcn.png" alt="Customer avatar" />
            <AvatarFallback>CN</AvatarFallback>
          </Avatar>
          <Avatar className="size-8 border-2 border-zinc-900">
            <AvatarImage src="https://github.com/shadcn.png" alt="Customer avatar" />
            <AvatarFallback>CN</AvatarFallback>
          </Avatar>
          <Avatar className="size-8 border-2 border-zinc-900">
            <AvatarImage src="https://github.com/shadcn.png" alt="Customer avatar" />
            <AvatarFallback>CN</AvatarFallback>
          </Avatar>
        </div>
        <span className="text-sm font-medium text-white">
          Loved by 5K+ customers
        </span>
        <ChevronRight 
          className="size-4 text-muted-foreground shrink-0" 
          aria-hidden="true"
        />
      </Link>
    </div>
  );
}
